---
name: wrap
description: End-of-chat hand-off. Record where we are in docs/roadmap.md so the next chat can pick up without this conversation. Use when the user says /wrap, "wrap up", "let's stop here", or is about to start a new chat.
---

# /wrap: hand off to the next chat

The next chat will not see this conversation. Everything it needs must be in the repo.

1. **Capture decisions.** Anything decided in this chat that isn't written down yet goes
   where it belongs: `docs/spec.md` (scope), an ADR in `docs/decisions/` (architecture),
   `docs/screens.md` (UI), `docs/frontend-notes.md` (learning). Keep it short.
2. **Update the Now section** at the top of `docs/roadmap.md` (replace it, don't append):
   - **Branch:** current branch and whether it's committed/pushed/has a PR
   - **Last done:** 1–3 bullets
   - **In progress:** what's half-finished, and the exact next step
   - **Open questions:** anything waiting on the user
3. **Tick / add** roadmap checkboxes to match reality.
4. **Show the diff summary and ask** before committing (the user reviews first). On a yes,
   commit on the current branch (never `main`) as `wrap: <summary>`. Ask before pushing.
5. Reply with a 3-line summary and the suggested first message for the next chat
   (usually just `/next`).
