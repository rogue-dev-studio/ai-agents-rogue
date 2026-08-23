# Personal folder taxonomy (reference)

Untuk skill `workspace-hygiene` — folder pribadi (Downloads, Desktop, dll.).

## Coding projects — pindah utuh (jangan pecah isi)

Deteksi folder anak sebagai project → pindah ke `Projects/<Stack>/<nama-folder>/`.

| Stack | Sinyal deteksi |
|-------|----------------|
| Laravel | `artisan` + `composer.json` |
| PHP | `composer.json` (tanpa `artisan`) |
| Node | `package.json` |
| NextJS | `package.json` + `next.config.*` |
| Vue | `package.json` + vue/nuxt config |
| Angular | `angular.json` |
| Python | `pyproject.toml` atau `requirements.txt` + entry app |
| Django | `manage.py` |
| DotNet | `*.sln` / `*.csproj` |
| Go | `go.mod` |
| Rust | `Cargo.toml` |
| JVM | `pom.xml` / `build.gradle` |
| Rails | `Gemfile` + `config/application.rb` |
| GitProject | `.git` + (`src`/`lib`/`app`) fallback |

**Wajib:** jangan sort file di dalam project (`vendor/`, `node_modules/`, `app/`, …).

## Mode `by-type` — file lepas saja

| Kategori | Folder | Ekstensi (contoh) |
|----------|--------|-------------------|
| Images | `Images` | `.png` `.jpg` `.jpeg` `.webp` `.gif` `.bmp` `.tif` `.tiff` `.heic` `.svg` `.ico` |
| Videos | `Videos` | `.mp4` `.mkv` `.mov` `.webm` `.avi` `.wmv` `.m4v` |

## Videos — kumpulkan per kategori folder sumber

Saat mengumpulkan video lintas drive (script `collect-videos.ps1`):

| Aturan | Perilaku |
|--------|----------|
| Exclude eksplisit | Jangan sentuh path yang user kecualikan (contoh: `D:\Anis`, `explore`, `UnityProjects`) |
| Kategori | Pindah ke `Videos/<nama-folder-induk>/` — pakai **nama folder tempat file berada**, bukan flat dump |
| Project Unity | Skip video di dalam project (`Assets/` + `ProjectSettings/`) |
| Sudah flat | Heuristik nama file (Telegram, Screen Recordings, Camera/VID_, dll.) bila folder asal tidak diketahui |

```powershell
.\ai-agents-rogue\scripts\collect-videos.ps1 -SourcePaths 'D:\BrankasDigital','D:\Download' -ExcludeRoots 'D:\ZonaKreatif\explore','D:\Anis' -Apply
```

## Photos — kumpulkan per kategori folder sumber

Hanya path yang user tentukan (contoh satu subfolder atau beberapa folder media):

| Aturan | Perilaku |
|--------|----------|
| Scope | Hanya folder sumber yang disebut user — jangan recurse drive penuh tanpa izin |
| Kategori | `Photos/<nama-folder-induk>/` (folder tempat file berada) |
| Exclude | `Anis`, `explore`, `Installers`/`Packages`/`ISO`, `UnityProjects`, project Unity (`Assets`+`ProjectSettings`), project coding (`package.json`, `composer.json`, dll.) |
| Skip asset | Unity `Assets/`, `Downloads/Compressed`, addon/extension/mockup/template, folder `icons`/`demo`/`textures`/`logo` di paket download, file dengan `.meta`, texture maps (diffuse/normal/albedo), mockup preview |
| `.jpg.rigj` | Valid (header+footer JPEG) → buang `.rigj`. Rusak → `Photos/<kategori>/_rusak/` |

```powershell
.\ai-agents-rogue\scripts\collect-photos.ps1 -SourcePaths 'D:\BrankasDigital','D:\Foto','D:\Download' -ExcludeRoots 'D:\Anis','D:\ZonaKreatif\explore','D:\Installers' -Apply
.\ai-agents-rogue\scripts\restore-project-photos.ps1 -PhotosRoot 'D:\Photos' -Apply
```
| Audio | `Audio` | `.mp3` `.wav` `.flac` `.aac` `.m4a` `.ogg` `.wma` |
| Documents | `Documents` | `.pdf` `.doc` `.docx` `.xls` `.xlsx` `.ppt` `.pptx` `.txt` `.rtf` `.odt` `.csv` `.md` |
| Archives | `Archives` | `.zip` `.rar` `.7z` `.tar` `.gz` `.bz2` |
| Installers | `Installers` | `.exe` `.msi` `.msix` `.dmg` `.apk` `.iso` `.img` `.appimage` |

## Installers — aturan paket utuh

Saat mengumpulkan installer (skill `workspace-hygiene`, script `collect-installers.ps1`):

| Bentuk | Perilaku | Contoh tujuan |
|--------|----------|---------------|
| File standalone | Pindah file saja | `Installers/CursorUserSetup-x64-3.9.16.exe` |
| ISO / image boot | Pindah utuh | `Installers/ISO/ubuntu-24.10-desktop-amd64.iso` |
| Folder paket | Pindah **seluruh folder** — jangan hanya `Setup.exe` atau `.AppImage` | `Installers/Packages/Navicat Premium 16.1.2 Linux64/` |
| AppImage sepaket | `.AppImage` + file/folder pendukung di folder yang sama → pindah folder induk utuh | `Installers/Packages/.../` |
| Arsip installer | Pindah **seluruh** `.zip`/`.rar`/`.7z` yang jelas distribusi installer | `Installers/Packages/flutter_windows_3.32.5-stable.zip` |

**Wajib:**

- Deteksi paket: `Setup.exe` / `Install.exe` **atau** `.AppImage` + file/folder pendukung → pindah folder induk paket.
- Folder bundle installer (WinRAR, RUFUS, Adobe, IObit, dll.): `ReadMe (How to Install).txt`, subfolder `Crack`, `BlockHost*.cmd`, atau `.rar` besar → pindah **seluruh folder** meski `Setup.exe` sudah pernah dipindah terpisah.
- Dedupe versi: simpan **hanya versi terbaru** per keluarga app (bandingkan angka versi + tanggal modifikasi).
- Jangan jalankan installer; hanya `Move-Item`.
- Jangan pecah isi paket (keygen/crack tetap ikut folder — user yang review).

**Helper:**

```powershell
.\ai-agents-rogue\scripts\collect-installers.ps1 -SourcePaths 'D:\Download','D:\BrankasDigital'
.\ai-agents-rogue\scripts\collect-installers.ps1 -SourcePaths 'D:\Download' -Apply -Dedupe
```
| Code | `Code` | file kode **lepas** (bukan isi project) |
| Other | `Other` | sisanya |

## Mode `by-extension`

Hanya untuk **file lepas**. Project tetap ke `Projects/<Stack>/`.

## Mode `by-face` (hanya jika diminta)

Cluster gambar berdasarkan wajah (lokal, DeepFace/Facenet):

| Hasil | Folder |
|-------|--------|
| Orang terdeteksi (cluster) | `Faces/Person_001/`, `Person_002/`, … |
| Tidak ada wajah | `Faces/NoFace/` |

- Deps: `pip install -r ai-agents-rogue/scripts/organize-by-face.requirements.txt`
- Script: `organize-by-face.py` via `-Mode by-face`
- Foto multi-wajah: memakai wajah terbesar sebagai label utama
- Akurasi tidak sempurna; rename folder Person_xxx ke nama orang boleh manual setelah review

## Depth

| Opsi | Perilaku |
|------|----------|
| Flat (default) | File di root + folder project di root |
| Recurse | File lebih dalam, **tetap skip** isi coding project |

## Path terlarang

`C:\Windows`, Program Files, root drive mentah (`C:\`).
