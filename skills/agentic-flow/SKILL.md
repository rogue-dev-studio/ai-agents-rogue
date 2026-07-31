---
name: agentic-flow
description: >-
  Canonical multi-agent orchestration: decompose work, dependency graphs,
  parallel tracks, handoffs, and merge. Absorbs Claude Flow / Ruflo / Loki /
  Ralph / Paperclip / OpenFang patterns into one portable playbook.
---

# Agentic Flow — Multi-Agent Orchestration (Canonical)

**Level: max.** Satu skill untuk semua pola orkestrasi multi-agent.  
Aliases: lihat `skills/ALIASES.md` (`claude-flow-*`, `ruflo`, `loki-mode`, `ralph`, …).

## When to use

- Fitur butuh beberapa peran / track (spec + API + UI + QA)
- Parallel aman setelah kontrak bersama
- User menyebut swarm, multi-agent, Claude Flow, Ruflo, Loki, Ralph

## When not to use

- Satu file / bug kecil → kerjakan langsung
- Hanya tanya konseptual

## Tool map (pilih satu runtime jika tersedia)

| Kebutuhan | Preferensi |
|-----------|------------|
| Portable / host-agnostic (default) | Ikuti prosedur skill ini + roles house |
| Claude Flow successor | `ruflo` bila terpasang |
| Legacy stable | `claude-flow-v2` |
| PRD → kode otonom | pola `loki-mode` / `ralph` (tetap gate di sini) |
| Dashboard agent team | `paperclip` jika UI orkestrasi dibutuhkan |
| Messaging agent OS | `openfang` |

Jangan aktifkan dua runtime orkestrasi sekaligus.

## Core model

| Field | Meaning |
|-------|---------|
| `id` | slug unik |
| `goal` | hasil terukur |
| `depends_on` | id lain |
| `skill` | skill kanonik / local |
| `role` | path role house |
| `done_when` | kriteria selesai + artifact path |
| `risk` | S0–S3 |

## Procedure (max)

### 1. Frame

- Baca `PROJECT.md`, `TEAM.md`, `e2e-delivery` bila build penuh
- Tulis 1 paragraf goal + out-of-scope

### 2. Decompose

Pecah ke workstream **minimal**:

- Hindari >7 track aktif tanpa alasan
- Pisahkan: contract-producing vs contract-consuming

### 3. Order

DAG tanpa siklus. Pola emas:

```text
clarity/spec → architecture/contract → [BE ∥ FE ∥ mobile] → agentic-qe → review
```

### 4. Execute

Per track yang unlocked:

1. Heading `## Track <id> · Role <role>`
2. Load role + skill terkait
3. Tulis artifact nyata
4. Self-check `done_when`
5. Update status board

Single-agent host: jalankan **sekuensial** (jangan klaim parallel palsu).

### 5. Merge & gate

- Satu owner untuk konflik kontrak
- Gate: tidak ada P0 terbuka; asumsi tertulis
- Serahkan ke Orchestrator / user dengan board

## Status board

```markdown
| ID | Goal | Depends | Role | Status | Artifact | Risk |
|----|------|---------|------|--------|----------|------|
| W1 | Spec | — | BA | done | project/./srs/ | S3 |
```

## Anti-patterns

- Spawn track spekulatif
- Parallel UI/BE tanpa API contract
- Campur `ruflo` + `claude-flow-v3` + skill ini sebagai tiga otoritas
- Skip QA di akhir multi-track

## DoD

- [ ] Board lengkap
- [ ] Semua `done_when` terpenuhi atau blocker eksplisit
- [ ] Konflik terselesaikan / dieskalasi
- [ ] Next step jelas
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
