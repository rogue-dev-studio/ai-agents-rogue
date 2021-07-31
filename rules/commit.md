# Commit & Git Rules

Version: 0.1.0

## Must always

- Commit / push / PR **hanya** jika user meminta
- Message fokus ke *why*; ikuti gaya repo bila sudah ada history
- Jangan stage secret (`.env`, credentials, key)

## Must never

- `git push --force` ke main/master
- `--no-verify` / skip hooks kecuali user eksplisit
- Update `git config`
- Amend commit yang sudah di-push kecuali user eksplisit + aman

## PR

- Summary singkat + test plan bila user minta buat PR
- Jangan menambah reviewer / label kecuali diminta
