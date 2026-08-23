#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Cluster loose images by face identity. Dry-run by default.
Requires: pip install -r organize-by-face.requirements.txt
"""
from __future__ import annotations

import argparse
import os
import shutil
import sys
from pathlib import Path

IMAGE_EXT = {".png", ".jpg", ".jpeg", ".webp", ".gif", ".bmp", ".tif", ".tiff", ".heic"}
BUCKET_SKIP = {
    "Images", "Videos", "Audio", "Documents", "Archives", "Installers",
    "Code", "Other", "Projects", "Faces",
}


def forbid_path(path: Path) -> bool:
    s = str(path.resolve())
    low = s.lower()
    if len(s) <= 3 and s.endswith(":"):
        return True
    if "\\windows" in low or "/windows" in low:
        if low.rstrip("\\/").endswith("windows") or "\\windows\\" in low or "/windows/" in low:
            if "system32" in low or low.rstrip("\\/").endswith("windows"):
                return True
    if "program files" in low and ("\\program files" in low or "/program files" in low):
        # only block if path is under Program Files itself as target root
        pass
    name = path.name.lower()
    if name in {"windows", "system32", "program files", "program files (x86)"}:
        return True
    return False


def list_images(root: Path, recurse: bool) -> list[Path]:
    files: list[Path] = []
    if recurse:
        for p in root.rglob("*"):
            if not p.is_file():
                continue
            if p.suffix.lower() not in IMAGE_EXT:
                continue
            parts = set(p.relative_to(root).parts[:-1])
            if parts & BUCKET_SKIP:
                continue
            if "Projects" in p.relative_to(root).parts:
                continue
            files.append(p)
    else:
        for p in root.iterdir():
            if p.is_file() and p.suffix.lower() in IMAGE_EXT:
                files.append(p)
    return files


def unique_dest(dest: Path) -> Path:
    if not dest.exists():
        return dest
    stem, suf = dest.stem, dest.suffix
    i = 1
    while True:
        cand = dest.with_name(f"{stem}_{i}{suf}")
        if not cand.exists():
            return cand
        i += 1


def embed_faces(paths: list[Path]):
    try:
        from deepface import DeepFace
        import numpy as np
    except ImportError as e:
        print(
            "Missing deps for by-face. Install once:\n"
            "  pip install -r ai-agents-rogue/scripts/organize-by-face.requirements.txt\n"
            f"Detail: {e}",
            file=sys.stderr,
        )
        sys.exit(2)

    records = []
    for p in paths:
        try:
            reps = DeepFace.represent(
                img_path=str(p),
                model_name="Facenet",
                detector_backend="opencv",
                enforce_detection=True,
                align=True,
            )
        except Exception:
            records.append({"path": p, "embedding": None, "faces": 0})
            continue
        if not reps:
            records.append({"path": p, "embedding": None, "faces": 0})
            continue
        # largest face by facial_area area if present
        best = reps[0]
        best_area = 0
        for r in reps:
            area = 0
            fa = r.get("facial_area") or {}
            if fa:
                area = int(fa.get("w", 0)) * int(fa.get("h", 0))
            if area >= best_area:
                best_area = area
                best = r
        emb = np.asarray(best["embedding"], dtype=float)
        records.append({"path": p, "embedding": emb, "faces": len(reps)})
    return records


def cluster_embeddings(records, threshold: float = 0.40):
    """Greedy clustering on cosine distance (Facenet)."""
    import numpy as np

    labeled = []
    centroids = []  # list of (label_idx, embedding)

    for rec in records:
        emb = rec["embedding"]
        if emb is None:
            labeled.append({**rec, "label": "NoFace"})
            continue
        # normalize
        n = np.linalg.norm(emb)
        if n == 0:
            labeled.append({**rec, "label": "NoFace"})
            continue
        emb = emb / n
        best_i = None
        best_dist = 1.0
        for i, c in enumerate(centroids):
            dist = 1.0 - float(np.dot(emb, c))
            if dist < best_dist:
                best_dist = dist
                best_i = i
        if best_i is not None and best_dist <= threshold:
            label = f"Person_{best_i + 1:03d}"
            # update centroid (running mean)
            centroids[best_i] = centroids[best_i] * 0.7 + emb * 0.3
            centroids[best_i] = centroids[best_i] / np.linalg.norm(centroids[best_i])
            if rec["faces"] > 1:
                # keep primary person; note multi-face in report only
                pass
        else:
            centroids.append(emb)
            label = f"Person_{len(centroids):03d}"
        labeled.append({**rec, "label": label})
    return labeled


def main() -> int:
    ap = argparse.ArgumentParser(description="Organize images by face (opt-in, dry-run default)")
    ap.add_argument("--path", required=True, help="Folder to organize")
    ap.add_argument("--apply", action="store_true", help="Move files (default: dry-run)")
    ap.add_argument("--recurse", action="store_true")
    ap.add_argument("--threshold", type=float, default=0.40, help="Cosine distance threshold")
    args = ap.parse_args()

    root = Path(args.path).expanduser().resolve()
    if not root.is_dir():
        print(f"Folder not found: {root}", file=sys.stderr)
        return 1
    if forbid_path(root):
        print(f"Refusing system/forbidden path: {root}", file=sys.stderr)
        return 1

    images = list_images(root, args.recurse)
    if not images:
        print(f"No images under: {root}")
        return 0

    print(f"Scanning {len(images)} image(s) for faces…")
    records = embed_faces(images)
    labeled = cluster_embeddings(records, threshold=args.threshold)

    proposals = []
    for rec in labeled:
        label = rec["label"]
        dest_dir = root / "Faces" / label
        dest = unique_dest(dest_dir / rec["path"].name)
        # skip if already there
        try:
            if rec["path"].resolve().parent == dest_dir.resolve():
                continue
        except Exception:
            pass
        proposals.append((rec["path"], dest, label, rec["faces"]))

    if not proposals:
        print("Nothing to move.")
        return 0

    from collections import Counter
    counts = Counter(p[2] for p in proposals)
    print(f"Plan: {len(proposals)} image(s) → Faces/<Person_xxx|NoFace>/")
    for k, v in sorted(counts.items()):
        print(f"  {k}: {v}")
    print()
    for src, dst, label, nfaces in proposals[:40]:
        multi = f" (faces={nfaces})" if nfaces > 1 else ""
        print(f"  {src}")
        print(f"    -> {dst}{multi}")
    if len(proposals) > 40:
        print(f"  ... and {len(proposals) - 40} more")

    if not args.apply:
        print("\nDry-run only. Re-run with --apply after review.")
        return 0

    for src, dst, _, _ in proposals:
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(src), str(dst))
    print(f"Done. Moved {len(proposals)} image(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
