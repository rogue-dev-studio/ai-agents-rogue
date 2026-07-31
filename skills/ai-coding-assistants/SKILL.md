---
name: ai-coding-assistants
description: >-
  Canonical playbook for AI coding assistants and CLI pair-programmers
  (Claude Code, Kilo, Goose, OpenCode, multi-CLI toolkits). Use when choosing
  or operating an assistant workflow inside the project.
---

# AI Coding Assistants (Canonical)

**Level: max.** Aliases: `claude-cli`, `claude-codepro`, `kilo`, `goose`, `opencode`, `ai-toolkit`, `claudeup`, `claudish` (as assistant entry).

## When to use

- Memilih / mengonfigurasi asisten coding di environment
- Menegakkan quality gate saat pair-programming dengan AI CLI

## Tool map

| Kebutuhan | Preferensi |
|-----------|------------|
| Claude Code resmi | `claude-cli` |
| TDD / quality-enforced Claude | `claude-codepro` |
| Terminal pair programming | `kilo` / `goose` / `opencode` |
| Multi-vendor CLIs | `ai-toolkit` |
| Plugin/MCP management TUI | `claudeup` |

## Procedure

1. **Pilih satu assistant utama** per project (catat di `PROJECT.yaml` notes).
2. Pastikan auth/env sesuai `rules/security.md` (tidak commit key).
3. Saat coding: requirement → small diff → test → review (ikut `coding.md`).
4. Untuk perubahan besar: wajib lewat `e2e-delivery` / roles, jangan “chat-driven rewrite” tanpa artifact.
5. Aktifkan hooks/linter project bila ada; jangan bypass tanpa alasan.

## Quality bar (max)

- Diff terfokus; unexplained files = gagal
- Tes untuk perilaku baru
- Tidak memperkenalkan dependency diam-diam

## DoD

- [ ] Assistant terpilih terdokumentasi
- [ ] Perubahan lolos gate coding + QA relevan
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
