# Dinner Planner: Spec

**Status:** draft v0.7. Platform: web app (PWA), see ADR 001. No implementation details here (those go in ADRs).

## Problem
Planning dinners for a diet takes effort: picking varied meals from a recipe bank and
working out exactly what to buy. The app should do this work so the user only has to
cook and shop.

## Users
- **Personal app, for me.** Code is written cleanly with per-user data (own login)
  so it stays a good portfolio piece, but there's no shared catalogue and no onboarding
  for strangers.
- Cooks for **one** and meal-preps (cooks once, eats several times).

## Data: public code, private data
- Recipe content (scans, cards, text, extracted JSON, photos) lives in the DB, never in the repo.
- My recipes are only returned to my account (server-side allow-list, configured outside the repo).
- Other accounts, tests and README screenshots use demo recipes we write ourselves.

## Core concepts
- **Recipe**: title, hero image, cook time, tags (e.g. dairy-free), nutrition per portion
  (calories, fat, sat fat, carbs, sugar, fibre, protein, salt), ingredients with quantities,
  pantry staples ("you need": oil, sugar…), equipment, allergens, numbered steps (≈8).
- **Recipe bank**: my recipes, imported from my cards.
- **Cook session**: cook recipe X in week W, making N portions (N = meal-prep size).
- **Plan**: upcoming weeks (~1 month ahead, Mon–Sun), each a set of cook sessions. The app
  doesn't assign days: the user decides when in the week to cook.
- **History**: past cook sessions; used to avoid repeats until the bank is exhausted.
- **Pantry**: checklist of long-life items the user already has (spices, oils, sauces).
- **Grocery list**: what to buy for one week (Mon–Sun) = (ingredients for that week's sessions) − (pantry).
- **Preferences**: hard rules (never / veg-only) vs soft dislikes (less often).

## Features

### Must (v1)
- **M1. Meal plan**: auto-generate ~1 month of cook sessions with maximum variety.
- **M2. Flexible meal prep**: a session of N portions = N days of food. Sessions are planned
  per week, not per day: when to cook and eat them is up to the user (the app doesn't track it).
  Default pattern is configurable (e.g. "3 sessions/week, 2 portions each").
- **M3. Adjust the plan**: swap, skip, move (to another week), or change portions of a session.
  Swapping offers **2–3 suggested alternatives** that fit preferences and variety.
  Adjusting happens mainly in the **weekly review** a couple of days before the week, before
  shopping. Once a week has started, its sessions can be skipped or moved but not swapped
  (the ingredients are already bought). The generated plan is a starting point, not a commitment.
- **M4. No repeats**: use history to avoid repeats until the whole bank has been used.
- **M5. Grocery list** *(first-class feature)*: aggregated quantities for a fixed
  **Mon–Sun week**, scaled to each session's portions, minus pantry items. Check items off;
  ticks also show on each recipe's Card 1 ingredients. Toast notifications for actions.
- **M6. Pantry checklist**: mark long-life items you have / are out of. Feeds the grocery list.
- **M7. Meal instructions**: Card 1 (title, image, macros, ingredients, equipment) and
  Card 2 (numbered steps), following the layout of the meal-kit cards I'm used to. Screen stays awake while open (Wake Lock API).
- **M8. Card import** (my own tool, not an in-app feature): photos of a card's front + back
  → AI extraction → review & correct (hole punches) → saved to my private recipe bank,
  including the dish photo.
- **M9. Preferences**: veg/non-veg restriction; hard vs soft dislikes.
- **M10. Accounts**: Google sign-in. Accounts are keyed on our own user ID with linked
  sign-in identities, so other methods can be added later. Each user's data is private to them.

### Should
- **S1. Weekly tailoring**: "more veg this week", "not feeling X this week".
- **S2. Holidays**: mark dates/weeks with no planned dinners.
- **S3. Macros on the plan** (calorie tracking per day/week).
- **S4. Reminders**: push notifications for cook days and shopping day
  (needs the app added to the iPad home screen).

### Later / stretch
- **L1.** Apple Health integration (no web API, so this would need a native client; see ADR 001).
- **L2.** "Ask questions" search bar on the instructions card.
- **L3.** Suggest alternatives for missing ingredients.
- **L4.** Other sign-in methods (Sign in with Apple, passkeys, email).
- **L5.** In-app recipe upload for other users (reuses the M8 pipeline). Needs a cost model.

### Not doing
- Publishing recipe content in any form; scraping any service's app/website.
- Social/sharing features, ratings feeds, shopping-app integrations.

## Non-functional
- Simple, modern, minimal taps. Lightweight app; heavy lifting off-device where sensible.
- Responsive: iPad is the primary layout, and it must also work on desktop and phone widths.
- Installable PWA: home-screen icon, full-screen, works offline for the grocery list and instructions.
- Free/cheap to run. The only AI use in v1 is my card import (a few pence per card).
- Hosted on free tiers. Other accounts see only the demo recipes.

## Answered
- **Users:** personal app for me; per-user data model kept for clean design. *(Q1)*
- **Platform:** web app (PWA) instead of native iOS. *(ADR 001)*
- **Recipes:** my own cards, imported privately via AI extraction. *(Q2)*
- **Grocery window:** fixed Mon–Sun week. *(Q3, screens)*
- **Meal prep:** N-portion session = N days of food; planned per week, user decides the days. *(Q4, Q10, screens)*
- **Sign-in:** Google, linked to our own user ID. *(screens)*
- **Ask-questions bar:** stretch only. *(Q5)*
- **Pantry:** yes, as a checklist. Alternatives for missing items are "later". *(Q6)*
- **Swaps:** suggest 2–3 alternatives. *(Q7)*
- **Servings:** cooking for 1; portions = meal-prep size. *(Q8)*
- **Scaling:** linear from a per-portion base, rounded sensibly. *(Q9)*
- **AI costs:** only my card import, paid by me (pennies). *(Q11)*
- **Distribution:** hosted PWA, added to the iPad home screen. My recipes gated to my
  account by the backend; everyone else gets demo recipes. *(Q15, ADR 001)*

## Open questions
_None. Spec ready for Phase 2 (screens)._
