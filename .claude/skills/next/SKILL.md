---
name: next
description: Pick up the next item from docs/roadmap.md and work it as a lightweight slice (agree scope → build → close). Use when the user says /next, "what's next", "let's continue", or wants to resume the project.
---

# /next: work the next slice

Lightweight on purpose. One short check-in with the user, then build.

## 1. Orient (silently)
- Read `docs/roadmap.md`, starting with the **Now** section (hand-off from the last chat). Find the first unchecked item in the earliest unfinished phase
  (or the item the user named in the args).
- Check `git status` / current branch for in-progress work. If there is some, offer to finish that first.
- Read only the docs relevant to the item (spec, screens, related ADRs).

## 2. Agree (one message, then wait)
State in 2–3 lines:
- **Slice:** what it does
- **Done when:** observable outcome(s)
- **Out of scope:** anything tempting that we're *not* doing

If the item is too big for roughly one session, propose splitting it and add the pieces
to the roadmap. Wait for the user's go-ahead (a "yes" or a tweak is enough).

## 3. Build
- **Never work on `main`.** If on `main`, create `slice/<short-name>` (or `docs/<short-name>`
  for docs-only work) before changing any file.
- Docs/design phases (spec, screens, ADRs): draft, then ask the specific open questions;
  record answers in the doc.
- Logic: write failing tests first, then make them pass.
- UI: build it, and as you go explain the key front-end patterns in a few sentences each.
  Add concise entries to `docs/frontend-notes.md` for anything new.
- Stay inside the agreed scope. Note ideas as unchecked roadmap items instead of building them.

## 4. Close
- Walk the **Done checklist** in `docs/roadmap.md`. Mention any item that isn't met.
- Offer a review: "Want to review this with `/crit` before committing?" The user
  decides; skipping is fine.
- Tick the item in `docs/roadmap.md`; add follow-ups as unchecked items.
- Update the **Now** section of `docs/roadmap.md`.
- Leave changes **uncommitted** and tell the user the branch + files so they can review.
  Commit only after they say so (hooks will run). Don't push unless asked.
- End with one line: what's next on the roadmap.
