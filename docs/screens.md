# Screens

**Status:** draft v0.2. Screen list + navigation map. Sketches and responsive strategy come next
(see `roadmap.md`, Phase 2).

## Approach
Start from **journeys** (what the user is trying to do, and when), then derive screens from them.
Finally check coverage: every Must feature maps to at least one screen.

## Decisions
- **Weeks, not days.** The plan is a list of Mon–Sun weeks, each a set of cook sessions.
  The app never assigns a session to a day; the user decides when to cook.
- **Weekly review before shopping.** Swaps happen a couple of days before the week starts,
  then the grocery list is final. Once a week has started: skip or move only, no swaps.
- **Grocery list = one Mon–Sun week.** Ticks are shared with each recipe's Card 1 ingredients.
- **Instructions follow the meal-kit card layout** (Card 1 / Card 2) the user is used to.
- **Google sign-in**, linked to our own user ID so other methods can be added later.
- **As few screens as possible**, as long as it stays clean and intuitive.

## Journeys

| # | Journey | When | What the user needs |
|---|---------|------|---------------------|
| J1 | **Weekly review** | A couple of days before the week (S4 reminder later) | See next week's meals, swap/skip/change portions, then the list is final. |
| J2 | **Shop** | In the shop, usually on the phone | Next week's grocery list, offline, tick items as they go in the basket. |
| J3 | **Cook** | Any day of the week, in the kitchen | Pick one of this week's meals → Card 1 (ticks show what's been bought) → Card 2 steps. Screen stays awake. |
| J4 | **Double-check** | During prep | Re-open the grocery list or Card 1; ticks are kept. |
| J5 | **Change of plan** | Mid-week | Skip a session or move it to a later week. |
| J6 | **Pantry top-up** | Occasionally, or while cooking ("out of cumin") | Mark pantry items have / out of, so they appear on the next list. |
| J7 | **Set up / tweak** | First run, then rarely | Sign in, preferences, default meal-prep pattern. |

## Screens

| ID | Screen | Purpose | Journeys |
|----|--------|---------|----------|
| S-Weeks | **Weeks** *(home)* | Launch screen. **This week**: its sessions as recipe cards, tap to cook. **Next week**: the review, with sessions editable and a "Groceries" button. Later weeks below (~1 month). | J1, J3, J5 |
| S-Session | **Session sheet** *(sheet over Weeks)* | One session: open recipe, swap (2–3 suggestions, upcoming weeks only), skip, move to another week, change portions. | J1, J5 |
| S-Recipe | **Instructions** | Card 1 (title, image, macros, ingredients with grocery ticks, equipment) and Card 2 (numbered steps) as two pages of one screen. Wake lock while open. | J3, J4 |
| S-Shop | **Shopping** | **Groceries** (one week, aggregated, check off, toasts; defaults to the week you're shopping for, can switch to this/next week) and **Pantry** (have / out of) as two segments. | J2, J4, J6 |
| S-Settings | **Settings** | Account, veg restriction, hard/soft dislikes, default pattern (e.g. 3 sessions/week × 2 portions). | J7 |
| S-SignIn | **Sign in** | "Continue with Google". Only shown when logged out. | J7 |

Six screens, but only **three places** to navigate to (Weeks, Shopping, Settings). The session
sheet is an overlay; sign-in only appears when logged out.

## Navigation map

Top-level nav: **2 tabs (Weeks, Shopping) + a settings icon**.

```text
                 ┌──────────────────────┐
                 │ Sign in (Google)     │  only when logged out
                 └──────────┬───────────┘
                            ▼
   ┌─────────────────────────┬──────────────────────────┐
   │ Weeks (home)            │ Shopping                 │   ⚙ Settings (icon)
   │  This week  → cook      │  Groceries | Pantry      │
   │  Next week  → review    │                          │
   │  Later weeks            │                          │
   └──┬───────────┬──────────┴──────────────────────────┘
      │           │ tap a session (next/later week)
      │           ▼
      │   ┌───────────────────┐
      │   │  Session sheet    │── swap / skip / move / portions
      │   └─────────┬─────────┘
      │ tap a meal  │ open recipe
      │ this week   ▼
      ▼   ┌─────────────────────────┐
   ───────▶│ Instructions            │
          │ Card 1  ⇄  Card 2       │  swipe or tabs; wake lock
          └─────────────────────────┘
   Next week's "Groceries" button → Shopping › Groceries (that week)
```

### Taps from launch

| Task | Taps |
|------|------|
| Cook one of this week's meals | 1 |
| Grocery list | 1 |
| Swap a meal (weekly review) | 3 (session → Swap → pick) |
| Mark pantry item out | 3 (Shopping → Pantry → tick) |

## Coverage: Must features → screens

| Feature | Screen(s) |
|---------|-----------|
| M1 Meal plan | Weeks |
| M2 Flexible meal prep | Session sheet (portions), Settings (default pattern) |
| M3 Adjust the plan | Session sheet |
| M4 No repeats | No UI (scheduler logic); visible as variety in Weeks |
| M5 Grocery list | Shopping › Groceries; ticks on Instructions Card 1 |
| M6 Pantry | Shopping › Pantry |
| M7 Instructions | Instructions |
| M8 Card import | n/a, my own tool, not an in-app screen |
| M9 Preferences | Settings |
| M10 Accounts | Sign in, Settings |

Should features, placed now so they have a home later (not built yet):
S1 weekly tailoring → the week's review on Weeks; S2 holidays → Weeks; S3 macros → Weeks;
S4 reminders → notification deep-links into next week's review.

## Open questions
_None._
