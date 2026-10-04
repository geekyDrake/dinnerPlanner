# Dinner Planner

iPad-first, responsive **web app (PWA)** that plans dinners from my personal recipe bank
and generates grocery lists. Personal app, public repo (portfolio): move fast, keep it simple.

## Where things are
- `docs/roadmap.md`: build order, backlog checklist, per-slice done checklist. **Start here.**
- `docs/spec.md`: what we're building (source of truth for scope)
- `docs/screens.md`: screen sketches and navigation
- `docs/decisions/`: ADRs
- `docs/review-checklist.md`: review criteria (SOLID, simplicity, front-end)
- `docs/frontend-notes.md`: the user's front-end learning log
- `docs/initialDesignThoughtsPreAI.md`: original pre-AI notes (historical, don't edit)
- `web/`: PWA front-end. `backend/`: backend if needed (both stacks TBD via ADR)

## Working style
- Work in **slices**: small end-to-end features. Agree scope in 2–3 lines before building;
  no heavy gating. `/next` drives this.
- **Scope:** don't build anything not in `docs/spec.md`. Suggest it instead.
- **Testing:** TDD for logic (scheduler, grocery aggregation, backend). UI tests optional.
- **Teaching:** the user is a backend engineer, newer to front-end. When writing UI code,
  briefly explain the patterns used (state, rendering, layout, PWA APIs) with backend
  analogies where useful, and add concise entries to `docs/frontend-notes.md`.
  Explain, don't lecture.
- After each slice: tick `docs/roadmap.md`, add follow-ups as unchecked items.

## Code rules
- Platform is a PWA (ADR 001). Don't reintroduce native-only assumptions.
- iPad is the primary layout; always check phone width too. Touch-first (no hover-only UI).
- UI depends on interfaces for data so fakes can be swapped for the real backend.
- Small components, small modules, SOLID (see `docs/review-checklist.md`).
- Access to private recipes is enforced **server-side**; never trust the client.

## Git
- Hooks: `scripts/install-hooks.sh` once per clone. `.githooks/` dispatchers are
  language-agnostic and run `<component>/.hooks/{pre-commit,pre-push}` if present.
  A new component (e.g. `backend/`) adds its own `.hooks/` scripts; never put
  language-specific logic in `.githooks/`.
- pre-commit = fast (format/lint). pre-push = slow (build/test).
- **The user reviews before every commit:** leave work uncommitted until they approve.
- **Never commit to `main`.** Always create a branch first (`slice/<name>`, `docs/<name>`,
  `setup/<name>`); the pre-commit hook enforces this. Changes reach `main` via PR.

## Continuity between chats
Work is split across many chats. The repo is the memory, not the conversation:
- Start of a chat: read the **Now** section of `docs/roadmap.md` before anything else.
- End of a chat (or when the user says "wrap up"): run `/wrap`.
- Decisions go in ADRs/spec, not just chat. If it matters next week, write it down.

## Recipe data
Never commit recipe content (scans, cards, text, extracted JSON, photos). It lives in the DB.
Tests and screenshots use demo recipes we write ourselves.
