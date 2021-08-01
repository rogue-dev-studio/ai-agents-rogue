# Code Review — Reference (Expert)

Mandatory checklist for Code Reviewer and for developer self-check before handoff.

## A. Coding standards (`rules/coding.md`)

Catatan: header `@Author` / `@Date` / `@Last Modified` adalah **identitas saja** — **bukan** kriteria lulus/tolak code review.

- [ ] Readable, maintainable, scalable, efficient, secure, robust
- [ ] High performance and high security considered
- [ ] Language/framework/linter conventions followed
- [ ] No unnecessary / long / functional narration comments
- [ ] No duplicate or dead code
- [ ] Errors handled at boundaries; no unexpected unhandled failures
- [ ] No SonarQube (or pipeline-equivalent) errors/warnings introduced
- [ ] No more than one consecutive blank line
- [ ] Modals isolated; no layout or performance damage

## B. Query & persistence ban (blocker)

Reject if any of the following appear in application code without written Tech Lead exception:

- [ ] Raw SQL string literals (`SELECT`, `INSERT`, `UPDATE`, `DELETE` embedded in app code)
- [ ] `DB::select` / `DB::statement` / equivalent ad-hoc SQL helpers in controllers, services, jobs, views
- [ ] Database access from frontend / UI widgets
- [ ] Fat-controller queries that bypass repository/model persistence layer
- [ ] String-concatenated SQL (SQL injection risk)

Allowed (with project convention):

- Eloquent / ORM / query builder **inside** model or repository
- Migration DDL (versioned) under Database Engineer ownership
- Explicit Tech Lead waiver documented in task/PR for rare reporting SQL — must be parameterized

## C. Architecture

- [ ] No business rules only in controller/widget
- [ ] UI does not access database directly
- [ ] API/authz boundaries respected

## D. Verdict language

- **Blocker** — must fix before approve (includes any query ban violation)
- **Major** — must fix or explicit waiver
- **Minor** — nit / optional improvement
