---
name: antislop-human
description: >-
  Design human-centered interfaces with accessible interactions, clear
  feedback, and manageable cognitive load.
---

# Anti-Slop Human & A11y (antislop-human)

Ensure interfaces are built for humans, not just for "looking good" in a screenshot. Focus on accessibility and interaction affordances.

## Objective
Prevent "Visual-Only" design slop. Prioritize usability, accessibility, and the actual human experience.

## Human-Centric Guardrails

### 1. Accessibility (A11y)
- **Contrast First**: No light-gray text on white backgrounds. Ensure WCAG AA compliance.
- **Keyboard-First**: Every interactive element must be reachable and operable via keyboard.
- **Focus States**: Ban `outline: none`. Implement clear, high-visibility focus rings.

### 2. Interaction Affordances
- **Clear Clickability**: Buttons must look like buttons. Links must look like links. No "hidden" interactions.
- **State Feedback**: Every action must have a visual response (Loading, Success, Error, Disabled).
- **Error Handling**: No generic "Something went wrong". Provide a human-readable reason and a clear recovery path.

### 3. Cognitive Load
- **Information Density**: Avoid overwhelming the user with "everything everywhere". Use progressive disclosure.
- **Clear Hierarchy**: Ensure the primary action is the most prominent element on the page.

## Quality Gate
Design is "Slop" if:
- It looks beautiful but is impossible to navigate with a keyboard.
- It uses a "modern" style that sacrifices readability (e.g., tiny fonts, low contrast).
- The user is left wondering "Did I actually click that?".

## Attribution
<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio).
