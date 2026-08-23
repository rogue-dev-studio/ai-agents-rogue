# Domain Bootstrap Flow

Version: 0.1.0

Orchestrator: gunakan saat prompt menyentuh domain pack (`simrs`, `hr`, custom) dan host belum tersync.

## Flow

```text
User prompt (domain intent)
    ↓
bootstrap-domain.ps1 (-Domain atau infer -Prompt)
    ↓
Sync skills / roles / rules → host (prompt-first, full catalog tetap)
    ↓
active-domain/{id}.json
    ↓
[new-project] optional
    ↓
start-feature / e2e-delivery + skill domain dari prompt
```

## Agent rules

1. **Jangan** `install.ps1 -Team <id>` pada workspace full-catalog kecuali user eksplisit minta subset sempit.
2. **Do** jalankan bootstrap jika skill domain belum ada di `.cursor/skills/` atau manifest `active-domain` kosong/stale.
3. **Do** route langsung ke skill domain dari prompt setelah bootstrap (tim virtual, bukan TEAM.yaml lock).
4. **Gap skill**: patch `teams/<id>/skills/`, lalu bootstrap `-Force` atau salin ke host; catat asumsi di `project/{id}/docs/` bila E2E aktif.
5. **Pack baru**: `-CreatePackIfMissing`, lengkapi pack, bootstrap ulang.

## Domain inference (prompt)

| Score keywords | Domain |
|----------------|--------|
| simrs, rumah sakit, rekam medis, IGD, BPJS, … | `simrs` |
| cv, resume, onboarding, screening, karyawan, … | `hr` |

Ambiguous → tanya singkat atau bootstrap keduanya hanya jika user minta.
