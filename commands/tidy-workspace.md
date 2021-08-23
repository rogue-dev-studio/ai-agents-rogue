# Tidy Workspace / Organize Folder

Merapihkan **folder pribadi** — **hanya saat command/permintaan ini dipakai**.

- File lepas → `Images/`, `Videos/`, …
- Project coding → `Projects/<Stack>/` utuh
- Jika diminta **berdasarkan wajah** → `Faces/Person_xxx/` (`-Mode by-face`)

## Lakukan

1. Pastikan user meminta merapihkan folder
2. Path + mode (`by-type` | `by-extension` | `by-face` | `custom`)
3. Role **Workspace Librarian** + skill **`workspace-hygiene`**
4. Dry-run → setuju → apply
5. Laporkan hasil

## Script

```powershell
.\ai-agents-rogue\scripts\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Downloads" -Mode by-type
.\ai-agents-rogue\scripts\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Pictures" -Mode by-face
.\ai-agents-rogue\scripts\organize-personal-folder.ps1 -Path "$env:USERPROFILE\Pictures" -Mode by-face -Apply
```

Deps `by-face` (sekali):

```powershell
pip install -r ai-agents-rogue/scripts/organize-by-face.requirements.txt
```
