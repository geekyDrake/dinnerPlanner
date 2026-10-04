# Review Checklist

Skim this when closing a slice or reviewing with `/crit`. Not every item applies every time.

## Scope & simplicity
- Is everything here in `docs/spec.md`? If not, cut it or add it to the spec deliberately.
- Is this the simplest thing that works? Any abstraction without a second use?
- Fewest taps: could the user get here with less?

## SOLID / structure
- **S**: each module has one reason to change (components render, hooks/stores hold state, services talk to data).
- **O**: new behaviour added by new types, not by growing `switch`/`if` chains in old ones.
- **L**: fakes/mocks can stand in for real implementations without special-casing.
- **I**: interfaces are small and specific (no "god" `DataService`).
- **D**: UI depends on interfaces, not concrete backends, so fake → real is a swap.

## Front-end
- Components are small; extract when one grows past a screen.
- State lives in the right place (local first, shared only when needed, server state cached, not copied).
- Layout checked on iPad (primary) and phone width; touch targets ≥ 44px; no hover-only UI.
- Works in an installed PWA on iPad Safari (the real target), not just desktop Chrome.
- Wake lock only on the screens that need it (instructions, grocery list), re-acquired on return.
- Accessible: semantic HTML, labels, keyboard focus, colour contrast, dark mode.

## Logic & data
- Business logic is testable without the UI.
- Tests cover the edge cases (empty meal bank, all meals used, skipped/swapped meals, holidays).
- Errors are surfaced to the user sensibly (toasts for grocery-list actions).
- No secrets or personal data committed; private recipe access checked server-side.
