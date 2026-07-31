---
name: remote-desktop-access
description: >-
  Canonical remote desktop / GUI access playbook: Guacamole, XFCE/xRDP,
  and VNC for environments that need a graphical desktop.
---

# Remote Desktop Access (Canonical)

**Level: max.** Aliases: `guacamole`, `xfce-ubuntu`, `vnc-desktop`.

## Procedure

1. Pastikan benar-benar butuh GUI (banyak tugas cukup headless).
2. Pilih transport: browser gateway (`guacamole`) vs full desktop (`xfce-ubuntu`) vs VNC (`vnc-desktop`).
3. Hardening: auth kuat, jangan expose port publik tanpa tunnel/VPN; ikuti `security.md`.
4. Dokumentasikan URL/port di notes project (bukan password di git).
5. Matikan/idle service saat tidak dipakai (biaya/GPU).

## DoD

- [ ] Akses teruji
- [ ] Kredensial tidak di repo
- [ ] Alasan GUI tertulis
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
