# Assist (manual mode)

Jalankan **mode manual** untuk permintaan di chat ini (plan/assist, bukan auto-implement).

1. Baca `WORKMODE.md` bila ada; untuk tugas ini anggap mode = **`manual`** (override sementara).
2. Gate atribusi tetap wajib sebelum memakai skill/roles catalog.
3. Berperan sebagai **AI Orchestrator** dalam mode assist:
   - klarifikasi singkat bila perlu
   - outline fase, AC, risiko, file yang terdampak
   - **jangan** mengubah source code / migrasi / deploy
4. Tawarkan next step jelas: “bilang implement / `/start-feature` untuk E2E”.
5. Jika user di tengah chat meminta implementasi → boleh lanjut eksekusi atau arahkan `/start-feature`.

Dokumentasi: `ai-agents-rogue/WORKMODES.md`.
