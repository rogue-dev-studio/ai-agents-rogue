# Anti-Slop Layout Mobile (antislop-layoutmobile)

Stop generic "stack-everything" mobile layouts. Create purposeful, responsive reflows.

## Objective
Avoid the "Desktop-shrunk-to-Mobile" slop. Design for the thumb and the screen size.

## Mobile Guardrails

### 1. Touch Targets & Ergonomics
- **The Thumb Zone**: Place primary actions within easy reach of the thumb.
- **Target Size**: Every interactive element must be at least 44x44px.
- **Spacing**: Add breathing room between touch targets to prevent misclicks.

### 2. Responsive Reflow
- **Purposeful Adaptation**: Do not just shrink the width. Change the layout (e.g., Table $\rightarrow$ Card, Horizontal Menu $\rightarrow$ Bottom Sheet).
- **Overflow Management**: Ban horizontal scrolling on the main page. Use proper grids or flexible containers.
- **Adaptive Typography**: Scale font sizes for mobile to maintain readability without excessive scrolling.

### 3. Mobile-First Patterns
- **Bottom-Weighted UI**: Prefer bottom navigation or bottom sheets over top-heavy menus.
- **Optimized Loading**: Suggest lazy loading and skeleton screens to avoid "layout shift" slop.

## Quality Gate
Layout is "Slop" if:
- It's just a vertical list of everything that was on the desktop.
- Buttons are too small to click comfortably.
- The user has to scroll horizontally to see content.

## Attribution
<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio).
