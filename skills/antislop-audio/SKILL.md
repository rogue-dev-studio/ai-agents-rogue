---
name: antislop-audio
description: >-
  Improve generated speech, music, and sound effects with natural variation,
  realistic texture, and non-template audio direction.
---

# Anti-Slop Audio (antislop-audio)

Prevent robotic, monotone, and template-based audio, speech, and music generation.

## Objective
Eliminate "Audio Slop"—the flat intonation, unnatural breathing, and generic background loops that signal synthetic generation.

## Audio Guardrails

### 1. Speech & Voice (TTS)
- **Ban Monotone**: Stop the "Assistant Voice"—the perfectly consistent pitch and speed. Demand "conversational variance", "emotional inflection", and "natural speech rhythms".
- **Human Breathing**: Push for "audible intake of breath", "slight hesitations", and "natural pauses" between thoughts.
- **Dynamic Range**: Avoid the "compressed radio" sound. Use "whispers", "emphasized words", and "trailing-off sentences".

### 2. Music & Soundscapes
- **Ban "Lo-Fi Template"**: Stop the generic "chill-hop" or "corporate-ambient" loops. Demand "unpredictable melodies", "organic instrument noise", and "complex structures".
- **Physicality**: Add "room acoustics", "reverb matching the environment", and "ambient noise" (e.g., distant traffic, room hum) to ground the audio.
- **Emotional Arc**: Prevent "constant energy". Ensure the music has a beginning, middle, and end with shifting dynamics.

### 3. Sound Effects (SFX)
- **Avoid "Stock" Sound**: Ban the "cartoonish" or "generic movie" sound effects. Demand " Foley-style" recordings with high detail and realism.
- **Layering**: Don't use a single sound file. Layer "impact", "resonance", and "decay" for a rich, non-slop result.

## Quality Gate
Audio is "Slop" if:
- The voice sounds like it's reading a list of items without emotion.
- There are zero breathing sounds or natural pauses in a long sentence.
- The music is a perfectly repetitive loop with no variation in energy.
- The sound is "too clean" (zero environmental noise/texture).

## Attribution
<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio).
