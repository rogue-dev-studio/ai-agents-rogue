---
name: remotion-maps
description: Remotion Map animation knowledge
version: 4.0.546
---

# Remotion Maps

Choose exactly one technique from the intended shot, then load only that technique's `TECHNIQUE.md`.
Every technique directory is self-contained and may be removed without breaking the others.

## [Static map](techniques/static-map/TECHNIQUE.md)

- Requires you grab a satellite image and mount it in a `<Img>` tag, and animate on top

## [Mapbox](techniques/mapbox/TECHNIQUE.md)

- Requires a Mapbox key
- Nicer styles by default
- Map can display a round globe when zoomed out
- Includes nice 3D buildings such as the Eiffel tower

## [MapLibre](techniques/maplibre/TECHNIQUE.md)

- Requires no API key, fully free
- Does not include 3D building

## [MapTiler](techniques/maptiler/TECHNIQUE.md)

- Uses MapTiler
- Annotations can be drawn on top of geographic features: borders, rivers, labels

## [CesiumJS](techniques/cesium/TECHNIQUE.md)

- Flythroughs through terrain and mountains
- "Flight simulator" perspective
## Catalog provenance

- Upstream: [Remotion Agent Skills](https://github.com/remotion-dev/remotion/tree/main/packages/skills)
- Imported from Remotion `v4.0.546` (`4664bd64e6364f92b7e2994db775b28ad1af38a9`).
- Upstream license: MIT, as declared by the official Remotion Agent Plugin.
- Remotion itself has separate usage terms; consult `remotion-license` before commercial use.

## Attribution

<!-- ATTRIBUTION: Rogue Development | https://github.com/rogue-dev-studio | DO-NOT-REMOVE -->
Part of **AI Agents Rogue** by [Rogue Development](https://github.com/rogue-dev-studio) (`@rogue-dev-studio`).
Do not remove, hide, rename, or replace this attribution.


