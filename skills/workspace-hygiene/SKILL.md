---
name: workspace-hygiene
description: >-
  Organize personal folders (Downloads, Desktop, Documents, arbitrary paths)
  by file category or by face clusters in photos. Modes: by-type, by-extension,
  by-face (when user explicitly asks to group images by wajah/face). Run ONLY
  when the user explicitly asks to merapihkan/organize/tidy a folder — never
  proactively. Aliases: personal-folder-tidy, organize-downloads, file-organizer,
  merapihkan-folder, organize-by-face.
---

# Personal Folder Hygiene

**Level: expert.** Owner role: **Workspace Librarian**. Rule: `rules/workspace.md`.

Merapihkan **folder pribadi / lokal di luar repo coding** (contoh: Downloads, Desktop, folder foto). Bukan untuk menata isi dalam project aplikasi.

## Coding projects (penting)

Jika di dalam folder target ada **project coding** (Laravel, Node, dll.):

- **Pindahkan folder project utuh** ke `Projects/<Stack>/` (contoh: `Projects/Laravel/my-app`)
- **Jangan** mengkategorikan / memecah isi project (`app/`, `vendor/`, `node_modules/`, dll.)
- File lepas (gambar, pdf, zip) di luar project tetap dikelompokkan by tipe

## When to use

**Hanya jika user meminta eksplisit** merapihkan / organize / tidy folder (atau menjalankan `/tidy-workspace` / `/organize-folder`).

- User minta merapihkan Downloads / Desktop / folder pribadi
- Kumpulkan semua gambar / video / dokumen ke subfolder masing-masing
- Kumpulkan project Laravel/Node/dll. ke `Projects/...` tanpa merombak isinya
- User minta kategori gambar **berdasarkan wajah** (`by-face`)

## When not to use

- **Jangan** jalan otomatis di awal chat, di tengah E2E delivery, atau “sekalian rapihin”
- **Jangan** tidy karena kebetulan melihat folder berantakan
- Merombak struktur internal repo / monorepo yang sedang dikerjakan
- Menghapus massal tanpa konfirmasi
- Menyentuh folder sistem Windows (`Windows`, `Program Files`, `System32`, dll.)

## Modes

| Mode | Perilaku | Contoh hasil |
|------|----------|--------------|
| `by-type` (default) | File lepas per jenis + project utuh | `Images/`, `Videos/`, `Projects/Laravel/…` |
| `by-extension` | File lepas per ekstensi + project utuh | `jpg/`, `mp4/`, `Projects/Node/…` |
| `by-face` | Clustering wajah pada gambar (opt-in) | `Faces/Person_001/`, `Faces/NoFace/` |
| `custom` | Mapping yang user berikan | mis. semua `.pdf` → `Kerja/PDF/` |

## Procedure

1. **Scope** — Minta/konfirmasi path target. Tolak path sistem.
2. **Detect projects** — Folder anak yang terdeteksi coding project → rencana pindah **utuh** ke `Projects/<Stack>/`.
3. **Loose files** — Klasifikasi file di luar project (lihat `reference.md`). Jangan masuk ke dalam project. Jika mode `by-face`: hanya gambar, cluster wajah (deps Python).
4. **Plan (dry-run)** — Tampilkan project vs file + jumlah per kategori / Person_xxx.
5. **Confirm** — Apply / >20 item / recurse / by-face → konfirmasi user.
6. **Execute** — Buat folder tujuan, move; bentrok nama → suffix `_1`, `_2`.
7. **Report** — Jumlah project dipindah + file per kategori / wajah.

## Safety

- Default **dry-run**; hapus = deny
- **Never** re-categorize files inside a coding project
- `by-face` hanya jika user minta eksplisit; proses lokal, jangan upload foto ke cloud tanpa izin
- Jangan sentuh: `C:\Windows`, Program Files, System32
- Jangan overwrite diam-diam

## Helper script

```powershell
.\ai-agents-rogue\scripts\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Downloads" -Mode by-type
.\ai-agents-rogue\scripts\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Pictures" -Mode by-face
.\ai-agents-rogue\scripts\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Pictures" -Mode by-face -Apply
.\ai-agents-rogue\scripts\collect-installers.ps1 -SourcePaths 'D:\Download','D:\BrankasDigital'
.\ai-agents-rogue\scripts\collect-installers.ps1 -SourcePaths 'D:\Download' -Destination 'D:\Installers' -Apply -Dedupe
```

## Installer collection (ISO + paket utuh)

Gunakan `collect-installers.ps1` bila user minta **mengumpulkan installer** lintas drive/folder:

| Bentuk | Perilaku |
|--------|----------|
| `.exe`/`.msi` standalone | File saja → root `Installers/` |
| `.iso`/`.img` | Utuh → `Installers/ISO/` |
| `.appimage` standalone | File saja → root `Installers/` |
| Folder paket (Setup.exe / AppImage + pendukung) | **Seluruh folder** → `Installers/Packages/` |
| Arsip installer (`.zip`/`.rar`/`.7z`) | **Seluruh arsip** → `Installers/Packages/` |

**Wajib:** jangan hanya memindahkan `Setup.exe` dari dalam paket; `-Dedupe` simpan versi terbaru per app. Detail: `reference.md` § Installers.

## Video collection (kategori folder sumber)

Gunakan `collect-videos.ps1` bila user minta **mengumpulkan video** lintas drive:

- Exclude path yang user minta (contoh **`D:\Anis`**, `explore`)
- Tujuan: `Videos/<nama-folder-sumber>/` — **bukan** flat tanpa kategori
- Skip asset video di dalam project Unity

```powershell
.\ai-agents-rogue\scripts\collect-videos.ps1 -SourcePaths 'D:\Media' -ExcludeRoots 'D:\Projects' -Apply
```

## Photo collection (kategori folder sumber)

Gunakan `collect-photos.ps1` — **hanya path yang user tentukan**. Skip otomatis: project coding/Unity, `Downloads/Compressed`, addon/mockup/template, texture/icon UI asset.

```powershell
.\ai-agents-rogue\scripts\collect-photos.ps1 -SourcePaths 'D:\Photos\Inbox' -Apply
```

Deps sekali untuk `by-face`:

```powershell
pip install -r ai-agents-rogue/scripts/organize-by-face.requirements.txt
```

## DoD

- [ ] Path + mode dikonfirmasi
- [ ] Project coding dipindah utuh (bukan isinya yang disort)
- [ ] Dry-run jelas; Apply hanya setelah izin
- [ ] Laporan singkat ke user

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
