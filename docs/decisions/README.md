# Architecture Decision Records

One short file per real decision: `NNN-short-title.md` (e.g. `001-web-pwa-over-native-ios.md`).
Write one when a choice is hard to reverse or we compared real alternatives.
Superseding a decision = new ADR that links back; don't rewrite history.

**Style:** brief (one screen), honest about trade-offs, and always state the main driver
and what would make us revisit it.

## Index
- [001: Web app (PWA) instead of native iOS](001-web-pwa-over-native-ios.md): accepted

## Template

```markdown
# NNN: Title

**Status:** proposed | accepted | superseded by NNN
**Date:** YYYY-MM-DD

## Context
What problem, what constraints (cost, single user, iPad-first, simplicity).

## Options
1. Option A: pros / cons
2. Option B: pros / cons

## Decision
What we chose and the main driver.

## Consequences
What this makes easy, what it makes hard, risks, and what would make us revisit it.
```
