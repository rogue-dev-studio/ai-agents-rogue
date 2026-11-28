---
name: antislop-code
description: >-
  Keep generated code clear and maintainable by avoiding redundant comments,
  over-abstraction, generic naming, and template-driven implementation.
---

# Anti-Slop Code Hygiene (antislop-code)

Eliminate generic AI-generated code patterns, redundant comments, and over-abstraction.

## Objective
Produce "Clean Code" that looks like it was written by a senior engineer, not a template-generating model.

## Code Guardrails

### 1. Comment Hygiene
- **Ban Obvious Comments**: Never write `// This is a function to calculate sum`. The code should be self-documenting.
- **Remove "AI-Slop" Headers**: Delete repetitive headers like `// ===========================================================================`.
- **Value-Add Documentation**: Only write comments that explain *Why* (intent/trade-off), never *What* (implementation).
- **Remove "TBD/TODO" Templates**: Delete generic `// TODO: Implement error handling` unless it's a real, tracked task.

### 2. Implementation Patterns
- **Anti-Over-Abstraction**: Do not create a "GenericWrapperManagerFactory" when a simple function suffices. Avoid "Architecture for the sake of Architecture".
- **Concrete Logic**: Favor explicit logic over complex, generic patterns that hide the actual business rule.
- **Dry but not Over-Dry**: Do not abstract code to the point where it becomes unreadable (The "Abstractions-on-Abstractions" slop).

### 3. Naming & Structure
- **Precise Naming**: Avoid names like `data`, `info`, `manager`, `handler` if a more precise domain term exists.
- **Logical Grouping**: Group code by feature/domain, not by "Type" (e.g., avoid folders like `all_functions/` or `all_interfaces/`).

## Quality Gate
Code is "Slop" if:
- It contains comments that simply repeat the line of code.
- It uses a design pattern that adds 5 files to solve a 1-file problem.
- It looks like a "tutorial example" rather than production software.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
