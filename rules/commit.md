# Commit & Git Rules

Version: 0.1.0

## Must always

- Commit / push / PR **hanya** jika user meminta
- Message fokus ke *why*; ikuti gaya repo bila sudah ada history
- Jangan stage secret (`.env`, credentials, key)
- Terapkan `rules/public-identity.md` dan skill `public-contribution-identity`
- Sebelum commit, validasi message dengan `scripts/check-public-identity.ps1`
- Sebelum push/PR/release, validasi revision range yang akan dipublikasikan
- Gunakan identitas human/organisasi yang sudah dikonfigurasi dan tervalidasi repo; jangan membuat identitas baru

## Must never

- Menambahkan identitas AI, assistant, bot, Copilot, agent, atau model sebagai author, committer, co-author, sign-off, atau trailer publik
- Menambahkan trailer `Co-authored-by`, `Generated-by`, `Assisted-by`, atau ekuivalen yang memberi kredit kepada AI/agent
- `git push --force` ke main/master
- `--no-verify` / skip hooks kecuali user eksplisit
- Update `git config`
- Amend commit yang sudah di-push kecuali user eksplisit + aman; jika disetujui gunakan `--force-with-lease`

## PR

- Summary singkat + test plan bila user minta buat PR
- Jangan menambah reviewer / label kecuali diminta
