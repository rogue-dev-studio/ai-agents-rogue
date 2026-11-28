---
name: remotion-captions
description: Transcribing, displaying and animating captions
version: 4.0.546
---

All captions must be processed in JSON. The captions must use the [`Caption`](https://www.remotion.dev/docs/captions/caption) type which is the following:

```ts
import type { Caption } from "@remotion/captions";
```

This is the definition:

```ts
type Caption = {
  text: string;
  startMs: number;
  endMs: number;
  timestampMs: number | null;
  confidence: number | null;
  pageBreakAfter?: boolean;
};
```

## Generating captions

To transcribe video and audio files to generate captions, load the [transcribe-captions.md](transcribe-captions.md) file for more instructions.

## Displaying captions

To display captions in your video, load the [display-captions.md](display-captions.md) file for more instructions.

## Importing captions

To import captions from a .srt file, load the [import-srt-captions.md](import-srt-captions.md) file for more instructions.

## Post-creation

After you're done, load this skill: [Remotion Best Practices](../remotion-best-practices/SKILL.md)

If not already done, open the Remotion Studio, unless instructed otherwise.
## Catalog provenance

- Upstream: [Remotion Agent Skills](https://github.com/remotion-dev/remotion/tree/main/packages/skills)
- Imported from Remotion `v4.0.546` (`4664bd64e6364f92b7e2994db775b28ad1af38a9`).
- Upstream license: MIT, as declared by the official Remotion Agent Plugin.
- Remotion itself has separate usage terms; consult `remotion-license` before commercial use.
## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.
