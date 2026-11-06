# 002: Front-end: React + Vite + TypeScript single-page app

**Status:** accepted
**Date:** 2026-11-06

## Context
ADR 001 chose a PWA. Now we pick the front-end framework and tooling. Constraints:
- **Single user, everything behind a login.** No public pages, so no SEO and no need for
  server-side rendering (SSR).
- **iPad Safari (iPadOS 17) as an installed PWA**: offline grocery list and instructions
  (spec non-functional), home-screen install, wake lock.
- **The user is a backend engineer learning front-end**: the skills should transfer, and the
  docs, examples and AI help should be plentiful.
- **Simple and cheap:** a static build that any free host can serve. The backend is a
  separate ADR.
- **Testable logic:** scheduler and grocery maths are plain TypeScript, test-first (ADR 001).

## Options
1. **React + Vite (SPA).** Most widely used UI library: the most transferable skill, the
   biggest ecosystem, the most answers. Vite gives fast dev reload and a static build.
   `vite-plugin-pwa` generates the service worker (offline) and the install manifest.
   Cons: React's hooks model has gotchas (re-renders, effect dependencies); you pick your own
   router and data-fetching library.
2. **Next.js (React + server).** React plus routing, SSR and server routes in one framework.
   Server routes could double as the backend. Cons: SSR and server components add concepts we
   don't need behind a login; PWA/offline support is third-party and fights its caching;
   pushes towards hosting on Vercel. More framework than the app needs.
3. **SvelteKit.** Less code, simpler reactivity, often the nicest to learn. Can build a static
   SPA. Cons: smaller ecosystem and job market, so the skills transfer less; fewer
   examples for PWA edge cases on iPad Safari.
4. **Vue + Vite.** Gentle learning curve, good docs, same Vite PWA plugin. Cons: smaller
   ecosystem than React, and no stand-out advantage for this app.

## Decision
**Option 1: React + Vite + TypeScript, built as a static single-page app (SPA).**

Main driver: the most transferable skill for the user and the largest pool of help, with the
least framework surface. Nothing in the spec needs SSR, and an SPA is the simplest shape for
an offline-first PWA.

Tooling:

| Concern | Choice | Why |
|---------|--------|-----|
| Language | TypeScript (strict) | Types for the domain model; shared logic modules (ADR 001) |
| Build / dev server | Vite | Fast, static output, first-class PWA plugin |
| Offline + install | `vite-plugin-pwa` (Workbox) | Generates service worker + web manifest |
| Routing | React Router | Standard; screens map to routes (Weeks, Shopping, Settings, recipe) |
| Unit tests | Vitest | Same config as Vite; TDD for scheduler/grocery logic |
| UI tests (optional) | React Testing Library | Tests behaviour, not markup |
| Styling | CSS Modules + CSS custom properties | Plain CSS, scoped per component; you learn real CSS (layout, media queries), tokens for theme/dark mode |
| Lint / format | ESLint + Prettier | Run in `web/.hooks/pre-commit` |
| Package manager | npm | Comes with Node; one less tool |
| Node | Current LTS via nvm, pinned in `web/.nvmrc` | Node 18 on this Mac is end-of-life |

Server-data caching (e.g. TanStack Query) is decided with the backend ADR.

## Consequences
- **Easy:** static hosting anywhere, fast feedback while learning, fakes behind interfaces
  (CLAUDE.md) are ordinary TypeScript modules.
- **Hard:** we assemble the pieces ourselves (router, data layer). React's re-render and
  effect rules are the main learning hurdle; frontend-notes will cover them as they come up.
- **Styling trade-off:** CSS Modules is slower to write than Tailwind, but teaches CSS
  fundamentals. If styling becomes the bottleneck, Tailwind can be added later.
- **iPadOS 17:** Vite's default build targets Safari 16+, so no extra polyfills. iOS has no
  install prompt; the user adds the app to the home screen from Safari's Share menu.
- **Backend:** independent. If the backend ADR picks something with its own server, the SPA
  just calls its API.
- **Revisit if:** we need public, indexable pages (then Next.js or SvelteKit), or React's
  complexity outweighs the transferable-skills benefit in practice.
