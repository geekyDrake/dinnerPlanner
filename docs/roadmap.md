# Roadmap & Backlog

How we build this, in what order, and what's left. Tick boxes as we go: this file is
the "where were we?" when picking the project back up after a break.

## Now
_Hand-off between chats. Replaced (not appended) by `/wrap` at the end of each chat._

- **Branch:** `setup/workflow`: 1 squashed commit + this wrap commit. Not pushed, no PR yet.
- **Last done:**
  - Workflow set up: CLAUDE.md, `/next` + `/wrap` skills, git hooks, docs skeleton
  - Spec finished (v0.6, no open questions)
  - Pivoted from native iOS to a web app (PWA): [ADR 001](decisions/001-web-pwa-over-native-ios.md)
- **In progress:** nothing half-finished.
- **Next step:** offer to push `setup/workflow` and open a PR into `main` (ask first), then start
  **Phase 2: Screens** on a new branch `docs/screens`, beginning with "List every screen +
  navigation map" in a new `docs/screens.md`. Use the user's Card 1 / Card 2 ASCII sketches in
  `docs/initialDesignThoughtsPreAI.md` as the starting point for the instructions screens.
- **Context for next chat:**
  - Use **dummy data**: the user is still working out card scanning; real recipes aren't needed until Phase 6.
  - User's iPad maxes out at **iPadOS 17** (affects Wake Lock; see ADR 001).
  - User reviews before every commit; never commit to `main`.
- **Open questions:** none.

## The order (and why)

1. **Spec**: what we're building, prioritised (must / should / later). No tech.
2. **Screens**: low-fi ASCII sketches of every screen and the navigation between them.
   Cheap to change, and it tells us what data we actually need.
3. **Architecture**: decisions recorded as ADRs in `docs/decisions/`: backend choice,
   data model, where scheduling logic lives, auth/identity, images.
   Done *after* screens so the data model follows the UI, not the other way round.
4. **UI on fake data**: real screens against an in-memory/fake data source,
   built slice by slice. This is where the front-end learning happens and the app
   becomes usable early.
5. **Core logic (TDD)**: meal scheduler and grocery-list aggregation. Pure logic,
   test-first. Can run in parallel with phase 4.
6. **Real backend & DB**: swap the fake data source for the real one. If the app only
   talks to data through protocols, this is mostly plumbing.
7. **Polish & ship**: QA on desktop, iPad and phone; deploy; install to the iPad home screen.

## How a slice works

A **slice** = one small feature, built end-to-end (UI → logic → data), demo-able when done.

1. **Agree**: 2–3 lines: what it does and how we know it's done.
2. **Build**: Claude explains the front-end patterns used as it goes.
3. **Close**: run through *Done checklist* below, optionally review with `/crit`, tick it off here, commit.

Use `/next` to pick up the next unchecked item.

## Repo layout

```text
docs/       specs, screens, decisions (ADRs), notes, this roadmap
web/        PWA front-end, its own lint/format config and git hooks
backend/    backend service (language/platform decided in an ADR), its own hooks
.githooks/  language-agnostic dispatchers → run <component>/.hooks/<hook> if present
```

## Backlog

### Phase 0: Setup
- [x] Repo structure, CLAUDE.md, docs skeleton
- [x] Git hook dispatchers (`scripts/install-hooks.sh`)
- [x] Decide platform: web app (PWA) ([ADR 001](decisions/001-web-pwa-over-native-ios.md))
- [ ] Install Node.js LTS (`brew install node`): needed from the Phase 3 spike, not for Phase 2

### Phase 1: Spec
- [x] Draft `docs/spec.md` from the initial design thoughts
- [x] Resolve open questions in the spec
- [x] Prioritise features: must / should / later

### Phase 2: Screens
- [ ] List every screen + navigation map (`docs/screens.md`)
- [ ] ASCII sketch per screen (iPad first)
- [ ] Responsive strategy: how each screen adapts across desktop, iPad and phone widths (breakpoints, what collapses)
- [ ] Review the sketches against "fewest taps" principle

### Phase 3: Architecture
- [ ] ADR: front-end framework + tooling (e.g. React/Vite vs Next.js vs SvelteKit)
- [ ] ADR: backend + DB platform (e.g. Supabase vs Firebase vs Vercel + Postgres)
- [ ] ADR: auth (passkeys / magic link) + recipe access allow-list
- [ ] ADR: data model
- [ ] ADR: where scheduling runs (client vs server job)
- [ ] Spike (iPadOS 17): keep-awake via Wake Lock API with silent-video fallback
      (installed PWA + Safari tab), and a Web Push round-trip
- [ ] ADR: recipe data format + image storage
- [ ] ADR: portion/quantity model (per-portion base, linear scaling, rounding rules)
- [ ] Write ~5 demo recipes in that format: the **dummy data** for Phase 4, later test
      fixtures, screenshots and what other accounts see

### Phase 3b: Import my recipe bank (non-blocking; needed by Phase 6)
- [ ] Scan all recipe cards (front + back) into git-ignored `private/scans/`. Flat, even light, no glare.
- [ ] ADR: card import pipeline (scan → AI extraction → review), model, cost
- [ ] Spike: extract 3–5 cards, measure accuracy + cost (output stays in `private/`)
- [ ] Build the import tool (TDD on parsing/validation)
- [ ] Import all cards into the DB + review pass

### Phase 4: UI on fake data
_Slices get added here once screens are agreed._

### Phase 5: Core logic (TDD)
_Slices get added here once the spec is agreed._

### Phase 6: Real backend & DB
_Added after phase 3._

### Phase 7: Polish & ship
_Added later._

## Done checklist (per slice)

- [ ] Works on iPad (primary) **and** phone-width layouts
- [ ] Logic has tests (TDD for backend/scheduling/grocery logic; UI tests optional)
- [ ] Passes `docs/review-checklist.md` (quick skim)
- [ ] No scope creep: everything built is in the spec
- [ ] `docs/frontend-notes.md` updated with anything new learned
- [ ] Roadmap ticked; any new follow-ups added as unchecked items
