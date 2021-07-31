# Start Feature (E2E)

Jalankan **AI Agents Rogue end-to-end** untuk permintaan user di chat ini (override mode ke **`e2e`** untuk tugas ini).

1. Load `AGENTS.md`, `WORKMODES.md`, dan skill `e2e-delivery`.
2. Berperan sebagai **AI Orchestrator**.
3. Eksekusi pipeline penuh (Requirement → … → Testing/Review) **tanpa menunggu konfirmasi antar fase**, kecuali blocker wajib.
4. Tulis artifact ke `project/{id}/docs/` (bila project aktif) dan implementasi ke tree bila masuk Development.
5. Pakai roles di `ai-agents-rogue/roles/**` (atau path host).
6. Skills pendukung: `clarity`, `agentic-flow`, `agentic-qe`.
7. Akhiri dengan status board + asumsi + next step.

Jika project belum ada, jalankan `/new-project` dulu.
Mode persisten tidak wajib diubah; untuk ganti default pakai `/set-mode`.
