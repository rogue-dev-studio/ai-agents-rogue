# Maintainer: attribution & entitlement (Rogue only)

Internal packaging notes. End users: see `README.md` + `rules/author.md`.

**Jangan** bagikan atau commit `.attribution-private.xml` (sudah di `.gitignore`).

## Rotate / package

```powershell
$env:AAR_OFFLINE_DEV = "1"   # hanya sebelum repo GitHub live
.\scripts\generate-attribution-keys.ps1   # sekali
.\scripts\stamp-attribution.ps1
.\scripts\generate-attribution-seal.ps1
.\scripts\verify-attribution.ps1
.\scripts\verify-official-upstream.ps1
```

Setelah `https://github.com/rogue-dev-studio/ai-agents-rogue` live: **jangan** set `AAR_OFFLINE_DEV`.

## Publish checklist

- [ ] Private key **tidak** ada di git / release ZIP
- [ ] `ATTRIBUTION.seal` + `ATTRIBUTION.public.xml` + `GITHUB_ENTITLEMENT.json` + `INSTALL.md` ikut commit
- [ ] Fingerprint di `GITHUB_ENTITLEMENT.json` = hash `ATTRIBUTION.public.xml`
- [ ] README / INSTALL: catalog sebagai subfolder `ai-agents-rogue/` di project user

## Model proteksi (ringkas)

| Lapisan | Fungsi |
|---------|--------|
| RSA `ATTRIBUTION.seal` | Deteksi ubah skill/rules/scripts/LICENSE |
| Fingerprint + GitHub upstream | Tolak ganti public key / re-seal tidak resmi |
| Star + fork API | Tolak download-only |
| `rules/author.md` | Instruksi AI (harus terbaca; ikut di-seal) |

Enforcement ada di script + seal, bukan di kerahasiaan teks rule.
