# Team template

Copy folder ini menjadi `teams/<id>/` lalu isi manifest.

```powershell
Copy-Item -Recurse ai-agents-rogue\teams\_template ai-agents-rogue\teams\my-team
```

Edit:

1. `TEAM.yaml` — id, skills[], roles[]
2. `TEAM.md` — konteks domain untuk AI
3. (opsional) `skills/<name>/SKILL.md` — skill khusus tim
