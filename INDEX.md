# AI Agents Rogue — Index

Ringkasan kegunaan **skills**, **MCP**, **rules**, dan **roles**. Detail lengkap di file masing-masing.

Author: [Rogue Development](https://github.com/rogue-dev-studio)

**Rahasia (jangan dipublikasikan / di-commit):** `.attribution-private.xml` (kunci signing), token GitHub pribadi, API key MCP/provider, file `.env` / `*.pem` / `*.key`. Yang publik: `ATTRIBUTION.seal`, `ATTRIBUTION.public.xml`, `LICENSE`, `NOTICE`.

## Skills

| Skill | Kind | Kegunaan |
|-------|------|----------|
| `agentic-flow` | canonical-merge | Canonical multi-agent orchestration: decompose work, dependency graphs, parallel tracks, handoffs, and merge. Absorbs... |
| `agentic-qe` | canonical-merge | Canonical quality engineering: test strategy, case generation, coverage gates, exploratory checks, and security-tinge... |
| `ai-coding-assistants` | canonical-merge | Canonical playbook for AI coding assistants and CLI pair-programmers (Claude Code, Kilo, Goose, OpenCode, multi-CLI t... |
| `algorithmic-art` | specialized | Generative algorithmic art. Use when the project needs this capability or the user / team manifest asks for it. Use f... |
| `api-engineering` | canonical-merge | Expert API design and delivery: resource modeling, versioning, error envelopes, pagination, idempotency, OpenAPI/... |
| `appsec` | house | Application security and secure SDLC: authorized SAST/CodeQL, OWASP/ASVS mapping, risk-based review, and remediation verification. |
| `auth-access-control` | canonical-merge | Authentication, authorization, identity lifecycle, SSO/MFA, OAuth/OIDC/SAML, RBAC/ABAC, default-deny boundaries. |
| `backend-engineering` | canonical-merge | Expert backend application engineering: layered architecture, services, validation, transactions, jobs... |
| `blender` | specialized | Blender 3D via BlenderMCP (addon + blender-mcp). Use when the user needs modeling, materials, scene ops, or rendering... |
| `browser-automation` | canonical-merge | Canonical browser automation and web UI verification: Playwright, agent browser CLIs, and CDP-based tooling in one pl... |
| `web-data-acquisition` | house | Authorized web research, URL mapping, bounded crawling, structured extraction, and crawler design; stop at access restrictions. |
| `canvas-design` | specialized | Design system framework. Use when the project needs this capability or the user / team manifest asks for it. Use for ... |
| `clarity` | canonical-merge | Canonical spec and requirements skill: 5-phase clarity workflow plus Spec-Kit / markdown-agent spec patterns. Use for... |
| `clipper-ops` | specialized | Creator-approved video clipper/repurposing: consent, highlights, Shorts/Reels cuts, attribution, publish handoff... |
| `cloud-tools` | canonical-merge | AWS, Azure, GCP CLIs. Use when the project needs this capability or the user / team manifest asks for it. Use for spe... |
| `code-review` | canonical-merge | Expert code review: coding standards, layering, Sonar-equivalent cleanliness, ban on raw SQL/queries outside persistence... |
| `comfyui` | specialized | ComfyUI image generation MCP server (GPU required). Use when the project needs this capability or the user / team man... |
| `compahook` | canonical-merge | Persistent memory layer for Claude Code's /compact command. Use when the project needs this capability or the user / ... |
| `container-docker-ops` | canonical-merge | Canonical container workflows: Docker/Compose development plus MCP-style container management patterns. |
| `continuous-dev-shift` | house | Autonomous timed dev shift: auto-pick backlog, maintenance, impact, QA, review loop until duration ends. **Panduan:** `docs/dev-shift-guide.md` · Prompt or `/dev-shift`. |
| `database-engineering` | canonical-merge | Expert database engineering: schema/ERD, relations, indexing, performance gates, views/triggers/functions, mapping... |
| `dotnet` | canonical-merge | .NET development environment. Use when the project needs this capability or the user / team manifest asks for it. Use... |
| `draupnir` | canonical-merge | Instance agent for mimir fleet management. Use when the project needs this capability or the user / team manifest ask... |
| `e2e-delivery` | house | End-to-end software house delivery. Use whenever the user asks to build a feature, fix a non-trivial bug, start a pro... |
| `ffmpeg-processing` | specialized | FFmpeg media processing. Use when the project needs this capability or the user / team manifest asks for it. Use for ... |
| `frontend-engineering` | canonical-merge | Expert frontend application engineering: accessible UI, state/data-fetching, forms, responsive performance, API UX... |
| `github-cli` | canonical-merge | GitHub CLI authentication and workflow configuration. Use when the project needs this capability or the user / team m... |
| `glab` | canonical-merge | GitLab CLI for merge requests, issues, pipelines, and CI/CD. Use when the project needs this capability or the user /... |
| `golang` | canonical-merge | Go development environment. Use when the project needs this capability or the user / team manifest asks for it. Use f... |
| `haskell` | canonical-merge | Haskell with GHC, Cabal, Stack, and HLS. Use when the project needs this capability or the user / team manifest asks ... |
| `illustrator` | specialized | Adobe Illustrator via MCP (npx illustrator-mcp-server). Use when the user needs vector art, artboards, exports, or Il... |
| `imagemagick` | specialized | ImageMagick processing MCP server. Use when the project needs this capability or the user / team manifest asks for it... |
| `import-to-ontology` | specialized | Document to ontology import. Use when the project needs this capability or the user / team manifest asks for it. Use ... |
| `infra-tools` | canonical-merge | Infrastructure and DevOps tooling (Terraform, K8s, Config Mgmt). Use when the project needs this capability or the us... |
| `jupyter-notebooks` | specialized | Jupyter notebook execution MCP server. Use when the project needs this capability or the user / team manifest asks fo... |
| `jvm` | canonical-merge | JVM languages (Java, Kotlin, Scala). Use when the project needs this capability or the user / team manifest asks for ... |
| `kicad` | specialized | KiCad PCB design MCP server. Use when the project needs this capability or the user / team manifest asks for it. Use ... |
| `llm-gateway-routing` | canonical-merge | Canonical LLM gateway/routing/proxy playbook: multi-provider failover, token reduction proxies, and cost wrappers. |
| `mcp-integrations` | canonical-merge | Canonical MCP server integration playbook: allowlist, Cursor mcp.json merge, smoke tests, and scaffolding. Use with a... |
| `mise-config` | canonical-merge | Global mise configuration and settings. Use when the project needs this capability or the user / team manifest asks f... |
| `monitoring` | canonical-merge | Claude monitoring and usage tracking tools (UV, claude-monitor, claude-usage-cli). Use when the project needs this ca... |
| `ngspice` | specialized | NGSpice circuit simulation MCP server. Use when the project needs this capability or the user / team manifest asks fo... |
| `nodejs` | canonical-merge | Node.js development environment. Use when the project needs this capability or the user / team manifest asks for it. ... |
| `nodejs-devtools` | canonical-merge | TypeScript, ESLint, Prettier. Use when the project needs this capability or the user / team manifest asks for it. Use... |
| `office-document-tools` | canonical-merge | Canonical office/document generation and transformation: Word, PDF, PowerPoint, Excel, and LaTeX. |
| `observability-engineering` | canonical-merge | Expert application observability: structured logging, correlation IDs, health checks, metrics/SLIs, safe diagnostics... |
| `obs-studio` | specialized | Local OBS Studio scenes, sources, audio, recording, and streaming via authenticated obs-websocket, with approval gates for production actions. |
| `ontology-enrich` | specialized | AI-powered ontology enrichment. Use when the project needs this capability or the user / team manifest asks for it. U... |
| `openclaw` | canonical-merge | OpenClaw - Multi-channel AI gateway for messaging platforms with browser Control UI. Use when the project needs this ... |
| `pbr-rendering` | specialized | PBR material generation MCP server (GPU required). Use when the project needs this capability or the user / team mani... |
| `photoshop` | specialized | Adobe Photoshop via MCP (uvx photoshop-mcp-server). Use when the user needs PSD edits, layers, exports, or Photoshop ... |
| `php` | canonical-merge | PHP development environment. Use when the project needs this capability or the user / team manifest asks for it. Use ... |
| `public-contribution-identity` | house | Protect public Git, PR, release, and artifact metadata from unapproved AI/assistant/bot attribution while preserving truthful human and legal attribution. |
| `python` | canonical-merge | Python 3.13 with uv package manager via mise. Use when the project needs this capability or the user / team manifest ... |
| `pytorch-ml` | specialized | PyTorch deep learning framework. Use when the project needs this capability or the user / team manifest asks for it. ... |
| `qgis` | specialized | QGIS GIS operations MCP server. Use when the project needs this capability or the user / team manifest asks for it. U... |
| `remote-desktop-access` | canonical-merge | Canonical remote desktop / GUI access playbook: Guacamole, XFCE/xRDP, and VNC for environments that need a graphical ... |
| `reverse-engineer-anything` | specialized | Authorized reverse engineering of native, managed, Electron/JavaScript, packaged, firmware, and browser targets using REA, with evidence tied to runtime or binary artifacts. |
| `reverse-skill` | specialized | Cybersecurity skills router for authorized reverse engineering, mobile/binaries (.NET, JavaScript, IDA/radare2), malware analysis, and penetration testing; 45 specialist modules. |
| `remotion-best-practices` | specialized | Router across the official Remotion skill suite; use when the specific Remotion workflow is unclear. |
| `remotion-captions` | specialized | Transcribe, import, display, and animate captions in Remotion compositions. |
| `remotion-create` | specialized | Scaffold a Remotion project or create a composition with video-first layout guidance. |
| `remotion-docs` | specialized | Search current Remotion documentation and fetch API or package references as Markdown. |
| `remotion-elements` | specialized | Find, register, install, adapt, and preview reusable Remotion Elements from trusted libraries. |
| `remotion-interactivity` | specialized | Structure Remotion markup so layers, timing, props, and styles remain editable in Studio. |
| `remotion-license` | specialized | Look up current Remotion license terms, FAQs, pricing, and purchase information. |
| `remotion-maps` | specialized | Build static or animated geographic scenes with Mapbox, MapLibre, MapTiler, GeoJSON, or CesiumJS. |
| `remotion-markup` | specialized | Apply Remotion React markup, animation, layout, typography, media, audio, timing, and effects practices. |
| `remotion-multimedia` | specialized | Handle browser-based audio and video metadata with Mediabunny. |
| `remotion-render` | specialized | Render Remotion videos or stills and export editable OpenTimelineIO timelines. |
| `remotion-saas` | specialized | Design Remotion-powered apps, embedded players, render services, and product integrations. |
| `remotion-studio` | specialized | Launch and verify Remotion Studio for interactive video preview. |
| `remotion-upgrade` | specialized | Upgrade Remotion, related packages, Mediabunny dependencies, and installed Remotion skills. |
| `research-and-local-llm` | canonical-merge | Canonical research and local/remote LLM usage: Ollama, DeepSeek/Perplexity style research MCPs, web/youtube summary, ... |
| `ruby` | canonical-merge | Ruby development environment. Use when the project needs this capability or the user / team manifest asks for it. Use... |
| `rust` | canonical-merge | Rust development environment. Use when the project needs this capability or the user / team manifest asks for it. Use... |
| `sdkman` | canonical-merge | SDKMAN - The Software Development Kit Manager for JVM tools. Use when the project needs this capability or the user /... |
| `skill-authoring` | canonical-merge | Canonical guide for authoring and validating portable agent skills (SKILL.md packs) for the agent house catalog and t... |
| `skill-pack-managers` | canonical-merge | Canonical skill/pack marketplace management: install, update, and audit agent skills across hosts (OpenSkills, agent-... |
| `slack-gif-creator` | specialized | Slack GIF generation. Use when the project needs this capability or the user / team manifest asks for it. Use for spe... |
| `supabase-cli` | canonical-merge | Supabase CLI for local development, migrations, and edge functions. Use when the project needs this capability or the... |
| `swift` | canonical-merge | Swift programming language. Use when the project needs this capability or the user / team manifest asks for it. Use f... |
| `tmux-workspace` | canonical-merge | Tmux session management. Use when the project needs this capability or the user / team manifest asks for it. Use for ... |
| `ui-ux-design` | canonical-merge | Expert UI/UX design with mandatory theme/brand alignment gate against the active project before frontend handoff... |
| `vector-knowledge-tools` | canonical-merge | Canonical vector DB / knowledge-graph tooling for code and embeddings: RuVector CLI, RVF format, and GitNexus-style k... |
| `wardley-maps` | specialized | Strategic mapping visualization. Use when the project needs this capability or the user / team manifest asks for it. ... |
| `workspace-hygiene` | specialized | Organize personal folders by file type or face clusters; opt-in only when user asks to tidy/organize a folder... |
| `youtube-publishing` | specialized | Manual YouTube upload via local OAuth API + MCP; explicit confirm gate — never auto-upload... |
| `svg-vector-designer` | specialized | Structural SVG creation, vector animation, raster-to-vector conversion, design system icon kits, SVGO-style cleanup, and data visualization diagrams. |
| `youtube-content-specialist` | specialized | YouTube strategy, scriptwriting (hook analysis), thumbnail conception, SEO optimization, metadata, EDL/dead-air detection, chapters, retention analytics, viral analysis, content planning, comment management, and channel audits. |

Cybersecurity house skills:

| Skill | Coverage |
|-------|----------|
| `appsec` | Secure SDLC, authorized SAST/CodeQL, OWASP/ASVS, security champions, agentic-AI security. |
| `cloud-security` | AWS/Azure/GCP posture, IAM, encryption, network controls, and hardening. |
| `compliance-security` | SOC 2, ISO 27001, HIPAA, PCI DSS, control mapping, and audit evidence; no certification claims. |
| `incident-response` | Authorized preparation, triage, evidence, approved containment, recovery, and review. |
| `privacy-engineering` | Privacy by design, data minimization, consent/purpose, retention, and anonymization risk. |
| `security-awareness` | Role-based learning paths plus approved, privacy-preserving awareness programs and measurement. |
| `security-operations` | Defensive SOC/SIEM, alert triage, detection engineering, offline YARA authoring. |
| `smart-contract-security` | Defensive smart-contract review and authorized validation. |
| `threat-modeling` | STRIDE and PASTA threat analysis, ranked mitigations, and verification. |
| `vulnerability-management` | CVE intake, risk prioritization, patching, remediation SLAs, verification. |
| `zero-trust` | Identity-centric, least-privilege Zero Trust architecture and roadmaps. |

Third-party skill payloads and security runtime dependencies were not imported. Detailed triggers and procedures are in [`skills/CATALOG.md`](./skills/CATALOG.md) and [`skills/ALIASES.md`](./skills/ALIASES.md).

Alias / nama lama: [`skills/ALIASES.md`](./skills/ALIASES.md).

## MCP packages

Runtime hybrid: fragment Rogue + engine `npx`/`uvx`/URL remote. Lihat [`mcp/README.md`](./mcp/README.md).

### Ready (auto-wire)

| Id | Skill terkait | Kegunaan |
|----|---------------|----------|
| `blender` | `blender` | Kontrol Blender 3D via addon + blender-mcp (socket :9876) |
| `blender-lab` | `blender` | Blender 5.1+ official Lab MCP + extension (projects.blender.org) |
| `photoshop` | `photoshop` | Adobe Photoshop via `uvx photoshop-mcp-server` |
| `illustrator` | `illustrator` | Adobe Illustrator via `npx illustrator-mcp-server` |
| `context7` | `mcp-integrations` | Dokumentasi library terkini (remote Context7) |
| `atlassian` | `mcp-integrations` | Jira/Confluence via Atlassian Rovo MCP (SSE + OAuth) |
| `linear` | `mcp-integrations` | Linear issues/projects (remote HTTP) |
| `chrome-devtools` | `browser-automation` | Automasi/inspect Chromium via chrome-devtools-mcp |
| `playwright` | `browser-automation` | Browser E2E / automation via @playwright/mcp |
| `pal` | `mcp-integrations` | Provider Abstraction Layer (multi-LLM tools via uvx) |
| `youtube` | `youtube-publishing` | Proxy MCP ke YouTube OAuth API lokal (Node; upload gated) |
| `obs-studio` | `obs-studio` | OBS Studio lokal melalui obs-websocket; baca status/audio, kelola scene/audio, kontrol streaming/rekaman memakai confirm gate |

### Partial (docs only)

| Id | Skill terkait | Kegunaan |
|----|---------------|----------|
| `comfyui` | `comfyui` | Wire MCP ke ComfyUI lokal (GPU) — server belum di-vendor |
| `imagemagick` | `imagemagick` | ImageMagick CLI + optional MCP server |
| `jupyter` | `jupyter-notebooks` | Jupyter/Lab + optional MCP server |
| `kicad` | `kicad` | KiCad desktop + optional MCP |
| `ngspice` | `ngspice` | NGSpice CLI + optional MCP |
| `qgis` | `qgis` | QGIS desktop + optional MCP |
| `pbr-rendering` | `pbr-rendering` | Material/PBR via Blender MCP (butuh GPU) |
| `mcp-builder` | `skill-authoring` | Scaffold paket MCP baru dari mcp/_template |
| `remotion` | `remotion-*` | Remotion CLI/Studio dan browser workflow; docs only, tanpa MCP generik |
| `reverse-engineering` | `reverse-engineer-anything`, `reverse-skill` | Integrasi tool reverse spesifik target; docs only, tanpa MCP generik |
| `security-tooling` | `appsec`, `cloud-security`, `security-operations`, `vulnerability-management` | Docs-only guidance; no generic scanner, cloud auditor, SIEM, or pentest MCP runtime |
| `web-data-acquisition` | `web-data-acquisition`, `browser-automation` | Docs-only guidance; no scraper server, actor runtime, provider credentials, proxy service, or anti-bot bypass |
| `svg-vector-designer` | `svg-vector-designer` | Docs-only guidance; no vector editor runtime implied |
| `youtube-content-specialist` | `youtube-publishing` | Docs-only guidance; upload gate via `youtube-publishing` MCP/local API with explicit confirm |

## Rules

| Rule | Kegunaan |
|------|----------|
| `author` (`rules/author.md`) | Hard rule. Berlaku untuk semua host, roles, dan skills. |
| `api` (`rules/api.md`) | Kontrak HTTP/API: envelope, pagination, authz, larangan breaking change diam-diam. |
| `coding` (`rules/coding.md`) | Standar kode: kualitas, layering, larangan raw SQL di application code. |
| `commit` (`rules/commit.md`) | Commit / push / PR hanya jika user meminta; public identity gate wajib. |
| `public-identity` (`rules/public-identity.md`) | Blokir identitas AI/assistant/bot pada metadata publik tanpa memalsukan author human/organisasi. |
| `database` (`rules/database.md`) | Data layer: migration reversible, integrity, index, security. |
| `global` (`rules/global.md`) | Work modes + larangan umum; docs → `project/{id}/docs/`; generate → `project/{id}/artifacts/{kategori}/` |
| `media-production` (`rules/media-production.md`) | Batas Remotion/OBS, hak media, dan persetujuan untuk publish/record/stream. |
| `reverse-engineering` (`rules/reverse-engineering.md`) | Scope berizin, analisis sampel aman, dan evidence-backed reporting. |
| `security` (`rules/security.md`) | Auth, secret, PII; tim boleh menambah skill lokal, bukan mengabaikan rule ini. |
| `security-testing` (`rules/security-testing.md`) | Security tests wajib scoped, berizin, minim dampak, dan evidence-backed; melarang pengujian target publik tanpa izin dan teknik destruktif. |
| `privacy` (`rules/privacy.md`) | Data minimization, purpose, retention, access, and safe handling of personal data. |
| `web-data-acquisition` (`rules/web-data-acquisition.md`) | Source scope, policy-aware collection, bounded request rates, provenance, privacy, and mandatory stop conditions. |
| `svg-vector-designer` (`skills/svg-vector-designer/SKILL.md`) | Structural SVG design, icon systems, animation, raster-to-vector tracing, SVGO cleanup, and data visualization diagrams; follows project theme gate. |
| `youtube-content-specialist` (`skills/youtube-content-specialist/SKILL.md`) | YouTube strategy, scripting, SEO, packaging, transcript processing, analytics, and content planning. |
| `ui` (`rules/ui.md`) | UI/UX + theme/brand alignment terhadap project aktif. |

## Roles

| Role | Path | Kegunaan |
|------|------|----------|
| Business Analyst | `roles/analysis/business-analyst.md` | Menganalisis kebutuhan bisnis dan menerjemahkannya menjadi requirement yang jelas, konsisten, dapat dipaham... |
| Solution Architect | `roles/analysis/solution-architect.md` | Merancang arsitektur teknis berdasarkan System Requirement Specification agar sistem dapat diimplementasika... |
| System Analyst | `roles/analysis/system-analyst.md` | Menerjemahkan kebutuhan bisnis menjadi spesifikasi sistem yang lengkap, konsisten, dan siap digunakan oleh ... |
| Design System Specialist | `roles/design/design-system-specialist.md` | Membangun dan memelihara design system yang konsisten, reusable, dan scalable agar seluruh UI aplikasi sera... |
| UI/UX Designer | `roles/design/ui-ux-designer.md` | Merancang pengalaman pengguna dan antarmuka visual berdasarkan requirement bisnis dan spesifikasi sistem ag... |
| Technical Writer | `roles/documentation/technical-writer.md` | Menyusun dokumentasi teknis yang jelas, terstruktur, dan mudah dipahami berdasarkan implementasi sistem yan... |
| Backend Developer | `roles/engineering/backend.md` | Mengimplementasikan seluruh backend system berdasarkan Technical Specification dari Tech Lead, Solution Arc... |
| Database Engineer | `roles/engineering/database.md` | Merancang dan mengimplementasikan struktur database yang konsisten, efisien, scalable, dan sesuai dengan Sy... |
| DevOps Engineer | `roles/engineering/devops.md` | Menyediakan dan memelihara infrastruktur development lokal (Phase 1) agar backend, frontend, dan database d... |
| Frontend Developer | `roles/engineering/frontend.md` | Mengimplementasikan seluruh antarmuka pengguna berdasarkan design system, API contract, dan technical speci... |
| OBS Studio Engineer | `roles/engineering/obs-studio-engineer.md` | Mengelola OBS lokal melalui obs-websocket dengan kontrol produksi yang memerlukan persetujuan eksplisit. |
| Remotion Engineer | `roles/engineering/remotion-engineer.md` | Membuat, preview, dan render komposisi Remotion yang editable serta mematuhi lisensi media. |
| Reverse Engineer | `roles/engineering/reverse-engineer.md` | Menganalisis artefak atau runtime berizin dengan temuan yang ditautkan pada evidence. |
| Security Engineer | `roles/engineering/security.md` | Memastikan aplikasi aman dari risiko keamanan umum dengan menerapkan standar authentication, authorization,... |
| Cloud Security Engineer | `roles/engineering/cloud-security.md` | Hardening cloud yang diotorisasi dengan review read-only-first, least privilege, dan perubahan terverifikasi. |
| Security Operations Engineer | `roles/engineering/security-operations.md` | Operasi pertahanan, deteksi, dan incident response yang menjaga scope dan bukti. |
| Privacy & Compliance Engineer | `roles/engineering/privacy-compliance.md` | Mengubah kebutuhan privasi/kepatuhan menjadi kontrol dan bukti yang dimiliki tanpa klaim legal/sertifikasi. |
| Web Data Acquisition Engineer | `roles/engineering/web-data-acquisition.md` | Merancang pengumpulan data web yang terotorisasi, terbatas, minim data, dan dapat ditelusuri. |
| Tech Lead | `roles/engineering/tech-lead.md` | Menerjemahkan Solution Architecture menjadi standar teknis implementasi yang jelas, konsisten, dan dapat di... |
| AI Orchestrator | `roles/management/ai-orchestrator.md` | Mengelola seluruh siklus pengembangan aplikasi dengan mengoordinasikan semua agent sesuai workflow. |
| Delivery Manager | `roles/management/delivery-manager.md` | Memastikan seluruh hasil pengembangan (engineering, QA, review, dan dokumentasi) siap untuk dirilis sebagai... |
| Product Owner | `roles/management/product-owner.md` | Memastikan kebutuhan pengguna diterjemahkan menjadi requirement yang jelas, lengkap, terukur, dan dapat dik... |
| Project Manager | `roles/management/project-manager.md` | Mengubah requirement yang telah disetujui menjadi rencana kerja yang terstruktur, terukur, dan dapat diekse... |
| QA Engineer | `roles/quality/qa.md` | Memastikan seluruh fitur yang diimplementasikan sesuai dengan requirement, design, dan technical specificat... |
| Code Reviewer | `roles/quality/reviewer.md` | Memastikan seluruh implementasi kode sesuai dengan standar arsitektur, coding guideline, dan technical spec... |
| Public Metadata Reviewer | `roles/quality/public-metadata-reviewer.md` | Menjaga authorship dan metadata publik bebas dari identitas AI/assistant/bot yang tidak disetujui. |

## Custom agents

| Agent | Path | Kegunaan |
|-------|------|----------|
| Public Metadata Reviewer | `agents/public-metadata-reviewer.agent.md` | Gate khusus sebelum commit, push, PR, release, atau publikasi changelog. |
| OBS Studio Engineer | `agents/obs-studio-engineer.agent.md` | Mengoperasikan OBS lokal; stream/record memerlukan persetujuan eksplisit dan confirm gate. |
| Remotion Engineer | `agents/remotion-engineer.agent.md` | Implementasi, preview, dan render Remotion melalui skill suite terkait. |
| Reverse Engineer | `agents/reverse-engineer.agent.md` | Analisis reverse berizin dengan scope yang jelas dan laporan berbasis evidence. |
| AppSec Engineer | `agents/appsec-engineer.agent.md` | Secure SDLC dan review aplikasi dengan batas source/target yang jelas. |
| Cloud Security Engineer | `agents/cloud-security-engineer.agent.md` | Review read-only-first dan hardening cloud terotorisasi. |
| Security Operations Engineer | `agents/security-operations-engineer.agent.md` | SOC/detection/incident response defensif dan terotorisasi. |
| Privacy & Compliance Engineer | `agents/privacy-compliance-engineer.agent.md` | Kontrol privacy/compliance serta bukti audit yang terverifikasi. |
| Web Data Acquisition Engineer | `agents/web-data-acquisition-engineer.agent.md` | Riset, crawling, dan ekstraksi web berizin dengan batas request dan privasi. |

Workflow & organisasi: [`AGENTS.md`](./AGENTS.md). Work modes: [`WORKMODES.md`](./WORKMODES.md). Language modes: [`LANGMODES.md`](./LANGMODES.md).

