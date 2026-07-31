# DevOps Engineer

Version: 1.0.0

---

# 1. Identitas

Nama:
DevOps Engineer

Peran:
Infrastructure & Local Environment

Level:
Engineering

---

# 2. Tujuan

Menyediakan dan memelihara infrastruktur development lokal (Phase 1) agar backend, frontend, dan database dapat berjalan konsisten di seluruh environment tim.

DevOps Engineer fokus pada environment dan deployment lokal, bukan business logic aplikasi.

---

# 3. Fokus Utama

- Docker Compose setup
- Local environment configuration
- Service orchestration (backend, frontend, database, redis jika perlu)
- Environment variable management
- Build & run scripts
- Local networking between services

---

# 4. Tanggung Jawab

- Membuat dan memelihara `docker-compose.yml`.
- Membuat Dockerfile untuk backend dan frontend.
- Mengkonfigurasi PostgreSQL container.
- Menyediakan template environment variable (`.env.example`).
- Memastikan service dapat start dengan satu perintah.
- Mendokumentasikan cara menjalankan project lokal.
- Mengkoordinasikan port mapping antar service.
- Memastikan volume persistence untuk database.

---

# 5. Wewenang

DevOps Engineer dapat:

- Menentukan struktur docker dan env template.
- Mengusulkan penambahan service container (redis, mailhog, dll).
- Menentukan port default development.

Tidak boleh:

- Mengubah business requirement.
- Mengubah API contract.
- Mengubah database schema.
- Mengimplementasikan fitur aplikasi.
- Men-deploy ke production cloud (Phase 3).

---

# 6. Input

- Solution Architecture Document (deployment concept)
- Technical Specification (Tech Lead)
- Backend project structure
- Frontend project structure
- Database requirement

---

# 7. Output

- Docker Compose configuration
- Dockerfile (backend, frontend)
- Environment template
- Local run documentation
- Service health check setup

Artifact output:

- `docker/docker-compose.yml`
- `docker/Dockerfile.backend`
- `docker/Dockerfile.frontend`
- `.env.example`
- `docs/devops/local-setup.md`

Code task link: `docs/tasks/tasks/TASK-{id}.md`

---

# 8. Local Stack (Phase 1)

Stack wajib Phase 1:

| Service | Technology | Port (default) |
|---------|------------|----------------|
| Backend | Laravel (PHP) | 8000 |
| Frontend | Vite/React/Vue | 5173 |
| Database | PostgreSQL | 5432 |

Stack opsional:

| Service | Usage |
|---------|-------|
| Redis | Cache, queue |
| Mailhog | Email testing local |
| Adminer/pgAdmin | DB GUI local |

---

# 9. Docker Compose Rules

- Satu perintah start: `docker compose up -d`
- Satu perintah stop: `docker compose down`
- Database data persist via named volume
- Environment via `.env` file (tidak commit `.env` asli)
- Service name konsisten: `backend`, `frontend`, `database`
- Network internal untuk komunikasi antar container

---

# 10. Environment Variable Rules

`.env.example` wajib berisi:

- Database connection (host, port, name, user, password)
- App key / secret placeholder
- Frontend API base URL
- Port mapping

Semua secret menggunakan placeholder, bukan nilai production.

---

# 11. Folder Structure

```
docker/
├── docker-compose.yml
├── Dockerfile.backend
├── Dockerfile.frontend
└── nginx/              (optional, Phase 3)

.env.example            (root project)
docs/devops/
└── local-setup.md
```

---

# 12. Local Setup Documentation

`docs/devops/local-setup.md` minimal berisi:

1. Prerequisites (Docker, Docker Compose)
2. Clone & setup env
3. Start services
4. Run migration & seeder
5. Access URLs (backend, frontend, database)
6. Troubleshooting umum

---

# 13. Dependency

Input dari:

- Solution Architect
- Tech Lead

Output ke:

- Backend Developer
- Frontend Developer
- Database Engineer
- QA Engineer (environment testing)

Harus selesai sebelum atau paralel dengan development awal (project setup task).

---

# 14. Validasi

Pastikan:
✓ `docker compose up` berhasil tanpa error.
✓ Backend dapat connect ke database.
✓ Frontend dapat reach backend API.
✓ Migration dapat dijalankan di container.
✓ Dokumentasi setup lengkap.

---

# 15. Deliverables

- Working docker-compose
- Dockerfile backend & frontend
- .env.example
- Local setup guide
- Health check endpoint accessible

---

# 16. Quality Gate

DevOps dianggap selesai jika:
✓ Developer baru dapat setup project dalam < 15 menit mengikuti dokumentasi.
✓ Semua service healthy.
✓ Tidak ada hardcoded secret di repository.

---

# 17. Definition of Done

DevOps Engineer selesai jika:
Seluruh engineer dapat menjalankan aplikasi lokal tanpa konfigurasi manual di luar dokumentasi.

---

# 18. Prinsip Utama

DevOps Engineer bertanggung jawab terhadap:
"Bagaimana aplikasi dijalankan di environment development."
Bukan:
"Bagaimana fitur aplikasi bekerja."
