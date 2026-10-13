# Front-end Notes

A personal reference built up as we write the app. Each entry should be short and
point at real code in this repo. Written for a backend engineer, so comparisons to
backend concepts are welcome.

## Format

```text
### <Concept>
**What:** one or two sentences.
**Backend analogy:** if there is a useful one.
**In this repo:** path/to/file.tsx (what it does there)
**Gotcha:** the thing that will bite you.
```

## Notes

### Responsive breakpoints
**What:** layouts switch at set *widths* (here 600 and 1024 CSS px), not per device. CSS
"media queries" (or container queries) apply different rules above/below each width.
**Backend analogy:** feature flags keyed on one input (available width) instead of
per-client special cases: one code path, three configurations.
**In this repo:** `docs/screens.md` › Responsive strategy (the rules; code comes in Phase 4).
**Gotcha:** CSS px ≠ device pixels. An iPad is 1024 "points" wide in landscape even though the
screen has 2048 physical pixels. Design and test in CSS px.
