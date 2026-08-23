# Workspace Rules

Version: 0.2.0

Hard constraints untuk merapihkan **folder pribadi** (Downloads, Desktop, path lokal) berdasarkan kategori file. Detail: skill `workspace-hygiene` + role Workspace Librarian.

## Must always

- **Opt-in only:** jalankan tidy **hanya** jika user meminta merapihkan/organize folder (atau command `/tidy-workspace` / `/organize-folder`)
- Konfirmasi path target sebelum pindah file
- Default dry-run; Apply hanya setelah user setuju atau flag `-Apply` eksplisit
- Kelompokkan file lepas sesuai mode: `by-type` | `by-extension` | `by-face` | `custom`
- Mode `by-face` hanya jika user minta eksplisit (wajah / face); proses lokal
- **Coding project:** pindahkan folder project **utuh** ke `Projects/<Stack>/` — jangan mengkategorikan ulang isinya
- **Installer paket:** folder/zip/rar/7z/iso distribusi installer → pindah **sepaket** ke `Installers/` (`ISO/`, `Packages/`); jangan pecah hanya `Setup.exe` — gunakan `scripts/collect-installers.ps1`
- Tangani bentrok nama dengan suffix, jangan overwrite diam-diam
- Laporkan jumlah project + file per kategori setelah selesai

## Must never

- Merapihkan folder **tanpa** permintaan eksplisit user (termasuk “inisiatif” di E2E / chat lain)
- Memecah / mensortir isi project coding (Laravel `app/`, `vendor/`, `node_modules/`, dll.)
- Merapihkan / memindah isi `C:\Windows`, Program Files, System32, atau root drive tanpa folder user yang jelas
- Hard-delete file pribadi tanpa konfirmasi eksplisit
- Menjalankan installer (`.exe` / `.msi`) saat tidy — hanya pindahkan
- Membaca atau mengekspos isi secret (`.env`, key, password file) ke log

## Review triggers

- Recurse ke seluruh pohon folder besar
- >50 file dipindah
- Path di luar profile user (mis. disk D:/E: bersama)
- Mode custom / `by-face` pada folder foto besar
