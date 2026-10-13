# Screens

**Status:** draft v0.6. Screen list, navigation map, iPad sketches, responsive strategy, fewest-taps review. Phase 2 done
(see `roadmap.md`, Phase 2).

## Approach
Start from **journeys** (what the user is trying to do, and when), then derive screens from them.
Finally check coverage: every Must feature maps to at least one screen.

## Decisions
- **Weeks, not days.** The plan is a list of Mon–Sun weeks, each a set of cook sessions.
  The app never assigns a session to a day; the user decides when to cook.
- **Weekly review before shopping.** Swaps happen a couple of days before the week starts,
  then the grocery list is final. Once a week has started: skip or move only, no swaps.
- **Grocery list = one Mon–Sun week by default**, or 2–4 weeks combined for bulk buying (S5).
  Ticks are shared with each recipe's Card 1 ingredients.
- **Instructions = two cards, split by job.** Card 1 *Overview* ("have I got everything?"):
  image, times, macros, ingredient names ticked from the grocery list. Card 2 *Cook*: ingredient
  amounts in a sidebar beside the steps, so you measure without flipping back. Each step has an
  optional photo. Cooking for one means measuring everything yourself, so amounts belong next to the steps.
  Any number of steps (8 is typical); the steps area scrolls. Step photos reuse the imported
  card photos but stay small: fit as many steps on one view as possible.
- **Ingredient kinds:** each ingredient is *fresh*, *long-life* (bought by amount: rice, tins)
  or a *pantry staple* (have / out of: spices, oils, sauces). Pantry staples make up the pantry.
- **Diet = food groups you don't eat** (multi-select, e.g. no fish + no shellfish), with quick picks.
- **First run** shows Settings as setup. Later changes skip this week and next, with a popup saying so.
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
| S-Recipe | **Instructions** | Card 1 *Overview* (title, image, times, macros, ingredients with grocery ticks, equipment) and Card 2 *Cook* (amounts sidebar + numbered steps) as two pages of one screen. Wake lock while open. | J3, J4 |
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

See [Fewest-taps review](#fewest-taps-review) for every task.

## Sketches (iPad landscape)

Low-fi: layout and content only, no styling. Recipes shown are made-up demo recipes.
`[ ]` = button, `☐/☑` = checkbox, `‹ ›` = navigate, `⋯` = more. Phone and desktop layouts are
in [Responsive strategy](#responsive-strategy).

### Weeks (home)

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ Dinner Planner                                                                      ⚙    │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ THIS WEEK · Mon 5 – Sun 11 Oct                                     3 meals · 6 portions  │
│ ┌──────────────────────────┐ ┌──────────────────────────┐ ┌──────────────────────────┐   │
│ │       [ dish image ]     │ │       [ dish image ]     │ │       [ dish image ]     │   │
│ │ Chickpea Tikka Bowl      │ │ Lemon Herb Salmon        │ │ Black Bean Chilli        │   │
│ │ 35 min · 2 portions   ⋯  │ │ 25 min · 2 portions   ⋯  │ │ 40 min · 2 portions   ⋯  │   │
│ └──────────────────────────┘ └──────────────────────────┘ └──────────────────────────┘   │
│                                                                                          │
│ NEXT WEEK · Mon 12 – Sun 18 Oct      Review before you shop    [ Groceries · 14 items › ]│
│ ┌──────────────────────────┐ ┌──────────────────────────┐ ┌──────────────────────────┐   │
│ │       [ dish image ]     │ │       [ dish image ]     │ │       [ dish image ]     │   │
│ │ Miso Noodle Soup         │ │ Veggie Lasagne           │ │ Pork & Pepper Stir-fry   │   │
│ │ 20 min · 2 portions      │ │ 50 min · 2 portions      │ │ 25 min · 2 portions      │   │
│ └──────────────────────────┘ └──────────────────────────┘ └──────────────────────────┘   │
│                                                                                          │
│ LATER                                                                                    │
│ 19 – 25 Oct     Thai Green Curry · Mushroom Risotto · Harissa Chicken                    │
│ 26 Oct – 1 Nov  Sweet Potato Dahl · Teriyaki Tofu · Beef Ragu                            │
│ 2 – 8 Nov       Falafel Wraps · Prawn Linguine · Bean Burrito Bowl                       │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│                 [ ▦ Weeks ]                              [ 🛒 Shopping ]                 │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

- **This week:** tap a card → Instructions (you're cooking). `⋯` → Session sheet (skip/move/portions).
- **Next week and later:** tap a meal → Session sheet (swap is offered here).
- **Groceries button** → Shopping › Groceries for next week.
- **From Friday** (next week's review opens): a banner at the top, "Next week is ready to review ›",
  scrolls to next week. On iPad next week is already visible; the banner matters most on phone.
- No days are shown; the week is a set of meals.
- Empty: "No recipes in your bank yet". Loading: grey placeholder cards ("skeletons").

### Session sheet

Slides up over Weeks (a bottom sheet on phone, a centred panel on iPad). Example for a next-week meal:

```text
            ┌────────────────────────────────────────────────────────────────┐
            │ Miso Noodle Soup                                           ✕   │
            │ Next week · 20 min                              [ Open recipe ]│
            ├────────────────────────────────────────────────────────────────┤
            │ Portions                                  [ − ]   2   [ + ]    │
            │                                                                │
            │ Swap for                                                       │
            │ ┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐ │
            │ │  [ dish image ]  │ │  [ dish image ]  │ │  [ dish image ]  │ │
            │ │ Ramen Eggs Bowl  │ │ Tofu Pho         │ │ Udon Stir-fry    │ │
            │ └──────────────────┘ └──────────────────┘ └──────────────────┘ │
            │                                                                │
            │ Move to         [ 19 – 25 Oct  ▾ ]                             │
            │                                                                │
            │ [ Skip this meal ]                                             │
            └────────────────────────────────────────────────────────────────┘
```

- Tap a suggestion = swap done (toast: "Swapped · Undo"). The grocery list updates.
- **This week's** sessions show the same sheet without "Swap for" (ingredients already bought).
- Skip and move also toast with Undo, so no "are you sure?" dialogs.

### Instructions: Card 1 (overview: "have I got everything?")

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ ‹ Weeks                        [■ Overview ]  [ Cook ]                          ☀ Awake  │
├─────────────────────────────────────────────┬────────────────────────────────────────────┤
│ Chickpea Tikka Bowl                         │ INGREDIENTS                                │
│ Prep 10 min | Total 35 min | 2 portions     │ ☑  ◦ Chickpeas                             │
│ Vegetarian · Dairy-free                     │ ☑  ◦ Red onion                             │
│ ┌─────────────────────────────────────────┐ │ ☐  ◦ Baby spinach                          │
│ │                                         │ │ ☑  ◦ Basmati rice                          │
│ │             [ dish image ]              │ │ ☑  ◦ Tikka paste  (mustard)                │
│ │                                         │ │ ☐  ◦ Coconut yoghurt                       │
│ └─────────────────────────────────────────┘ │ ☑  ◦ Lime                                  │
│ ┌─ Per portion ──────────────────────────┐  │                                            │
│ │ Calories  Fat     Sat fat  Carbs       │  │ YOU NEED   olive oil · salt · sugar        │
│ │ 540kcal   14g     3g       78g         │  │            cumin  (out: on your list)      │
│ │ Sugar     Fibre   Protein  Salt        │  │ EQUIPMENT  saucepan · frying pan           │
│ │ 9g        13g     21g      1.9g        │  │ ALLERGENS  mustard                         │
│ └────────────────────────────────────────┘  │                                            │
└─────────────────────────────────────────────┴────────────────────────────────────────────┘
```

- Left: title, prep + total time, portions, tags, dish image, nutrition per portion.
- Right: ingredient **names** (no amounts) with a small icon (`◦`). **Ticks are shared with
  the grocery list**: ticking either one ticks both.
- "You need" = pantry staples; any marked "out" in the pantry are flagged. **Tap one to mark
  it out** (also on Card 2's sidebar): it goes on the next grocery list, toast with Undo.
- `☀ Awake` = wake lock is on (screen won't sleep). Swipe left/right or use the toggle to switch cards.
- Reopening a recipe resumes the card and scroll position you left.

### Instructions: Card 2 (cook: amounts + steps on one page)

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ ‹ Weeks   Chickpea Tikka Bowl · 2 portions      [ Overview ]  [■ Cook ]         ☀ Awake  │
├────────────────────┬─────────────────────────────────────────────────────────────────────┤
│ INGREDIENTS        │ ┌───────────────────┐ ┌───────────────────┐ ┌───────────────────┐   │
│ Chickpeas   1 tin  │ │                   │ │                   │ │                   │   │
│ Red onion       1  │ │                   │ │                   │ │                   │   │
│ Baby spinach  80g  │ │     [ photo ]     │ │     [ photo ]     │ │     [ photo ]     │   │
│ Basmati rice 130g  │ │     4:3, full     │ │                   │ │                   │   │
│ Tikka paste   30g  │ │   column width    │ │                   │ │                   │   │
│ Coconut yog.  60ml │ │                   │ │                   │ │                   │   │
│ Lime            1  │ └───────────────────┘ └───────────────────┘ └───────────────────┘   │
│                    │ 1 COOK RICE           2 PREP VEG            3 FRY CHICKPEAS         │
│ YOU NEED           │ Put the **rice** on   Slice the **red       Fry the **chickpeas**   │
│ Olive oil   1 tbsp │ to boil with 300ml    onion**...            with the **tikka        │
│ Salt, sugar        │ water...              ▸ Tip: highlighted    paste**...              │
│ Cumin       1 tsp  │                         tip text                                    │
│                    ├─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┤
│ EQUIPMENT          │   (scroll ↓)  4 SIMMER · 5 WILT SPINACH (no photo) · 6 BAKE         │
│ Saucepan, pan      │               7 MAKE DRESSING · 8 SERVE                             │
└────────────────────┴─────────────────────────────────────────────────────────────────────┘
```

- **Left sidebar (always visible):** ingredients with amounts in g/ml for the session's portions,
  then "you need" staples with amounts, then equipment. No flipping back to Card 1 to measure.
- **Steps:** any number (8 is typical). Recipes are never rewritten to fit the layout.
  Grid of 3 columns, reading across (1-2-3, 4-5-6, 7-8). The steps area scrolls; the sidebar
  and header stay put. 8 steps = 3 rows: about one screen and a bit on iPad landscape.
  Portrait iPad: 2 columns.
- **Photos are secondary:** they show what it should look like; fitting as many steps as
  possible on one view comes first. The sketch's photo size is a placeholder. In the UI phase,
  try smaller photos (e.g. a short 16:9 strip or a thumbnail) and pick the size where most of
  an 8-step recipe fits on one iPad landscape screen. Imported card photos are reused, cropped
  or scaled to fit.
- Optional: a step with no photo starts with its heading and text at the top of the box.
- Ingredient names in bold; tips highlighted (`▸ Tip:`). Amounts in step text match the portions.

### Shopping › Groceries

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ Shopping                         [■ Groceries ]  [ Pantry ]                         ⚙    │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ From  ‹ NEXT WEEK · Mon 12 Oct ›         Weeks  [■ 1 ] [ 2 ] [ 3 ] [ 4 ]    5 / 14 got   │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ FRESH                                                                                    │
│ ☐  Pork loin strips         250g        Pork & Pepper Stir-fry                           │
│ ☐  Red pepper               2           Stir-fry, Veggie Lasagne                         │
│ ☐  Baby spinach             80g         Chickpea Tikka Bowl                              │
│ LONG-LIFE                                                                                │
│ ☐  Udon noodles             2 × 150g    Miso Noodle Soup                                 │
│ ☐  Lasagne sheets           6           Veggie Lasagne                                   │
│ PANTRY TOP-UP                                                                            │
│ ☐  Cumin                                (out in pantry)                                  │
│                                                                                          │
│ GOT                                                                                      │
│ ☑  Red onion                3           3 recipes                                        │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│                 [ ▦ Weeks ]                              [ 🛒 Shopping ]                 │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

- Default: **one Mon–Sun week**, the week you're shopping for (next week once its review opens on Friday).
  `‹ ›` moves the start week (this week / next week).
- **Bulk buy (S5):** pick 2–4 weeks to see their combined list. Quantities add up across the
  weeks. **Fresh** is collapsed in a multi-week view ("buy nearer the time"); long-life items
  are what you'd bulk buy.
- **Ticks belong to each week:** ticking "Basmati rice" in a 3-week view marks it got in all
  three weeks. When each week comes round, only its fresh items are left to buy.
- Tap a row to tick it: it moves to **Got** with a toast ("Red pepper got · Undo").
- Each row shows which recipes need it (secondary text).
- Swapping a later week's meal after bulk buying can leave you with spare stock; the app doesn't
  track leftovers (yet).
- Offline: works from the saved copy, with a small "Offline" banner. Ticks sync when back online.
- Empty: "Nothing to buy this week".

### Shopping › Pantry

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ Shopping                         [ Groceries ]  [■ Pantry ]                         ⚙    │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ OUT OF  (added to your next grocery list)                                                │
│ [ Cumin ✕ ]                                                                              │
│                                                                                          │
│ HAVE   (tap to mark as out)                                                              │
│ [ Olive oil ] [ Salt ] [ Sugar ] [ Soy sauce ] [ Paprika ] [ Chilli flakes ]             │
│ [ Rice vinegar ] [ Honey ] [ Garlic granules ] [ Stock cubes ] ...                       │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│                 [ ▦ Weeks ]                              [ 🛒 Shopping ]                 │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

- One tap moves an item between Have and Out (toast with Undo).
- Chips rather than a long list: pantries are mostly "have", so this stays compact.

### Settings

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│ ‹ Back                               Settings                                            │
├──────────────────────────────────────────────────────────────────────────────────────────┤
│ ACCOUNT        Signed in with Google                               [ Sign out ]          │
│                                                                                          │
│ I DON'T EAT    [ Meat ] [ Poultry ] [■ Fish ] [■ Shellfish ] [ Pork ] [ Beef ] [ Dairy ] │
│                Quick picks: ( Vegetarian ) ( Pescatarian ) ( No seafood )                │
│ NEVER          [ Mushrooms ✕ ]  [ + Add ]                                                │
│ LESS OFTEN     [ Aubergine ✕ ]  [ + Add ]                                                │
│                                                                                          │
│ MEAL PREP      [ − ] 3 [ + ] sessions a week     [ − ] 2 [ + ] portions each             │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

- **I don't eat:** food groups, multi-select. Quick picks just tick the right groups
  (Vegetarian = meat, poultry, fish, shellfish; No seafood = fish, shellfish). Hard rule.
- **Never / Less often:** specific ingredients or tags from the recipe bank.
- **First run:** after the first sign-in, this same screen is shown as setup (with a
  "Plan my dinners" button) before the first plan is generated.
- **Later changes:** save immediately. When you leave Settings after changing something, a
  popup explains: "Changes apply from 19 Oct. This week and next stay as planned."

### Sign in

```text
┌──────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                          │
│                                     Dinner Planner                                       │
│                         Plans your dinners. Writes your shopping list.                   │
│                                                                                          │
│                              [ G  Continue with Google ]                                 │
│                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

## Responsive strategy

Layouts change by **available width**, not by device. The same rules then cover split-screen
on iPad, a resized desktop window, and rotating the iPad mid-recipe.

### Width ranges

Widths are in CSS pixels (points on Apple devices, not physical pixels).

| Range | Width | Typical devices |
|-------|-------|-----------------|
| **Phone** | < 600 | iPhone portrait (375–430), iPad split-screen (narrow side) |
| **Tablet** | 600 – 1023 | iPad portrait (768–834), iPad split-screen (wide side) |
| **Wide** | ≥ 1024 | iPad landscape (1024–1366), desktop |

- **Test device:** the user's iPad, probably an iPad Pro 10.5" (2017; to be confirmed):
  1112 wide in landscape (Wide), 834 in portrait (Tablet). Its last update is iPadOS 17.
- **Design target for Wide is 1024**, the narrowest landscape iPad, so the layout has some
  spare room on the test device and fits every iPad.
- **Desktop:** the Wide layout, centred, with a max content width of 1280. No desktop-only layout.

### Global rules

- **Navigation:** a bottom tab bar (Weeks, Shopping) at every width. Only 2 tabs, so a
  sidebar would waste the width that Card 2 needs, and one nav component is simpler.
  Settings stays a ⚙ icon top-right.
- **Instructions hides the tab bar** (full-screen, back button top-left) to give the steps room.
- **Touch targets** at least 44 × 44 at every width, including desktop (touch-first).
- **Rotation / resize keeps your place:** same card, same scroll position, same ticks.
- **Sheets:** bottom sheet on Phone; centred panel (about 560 wide) on Tablet and Wide.

### Per screen

| Screen | Phone (< 600) | Tablet (600–1023) | Wide (≥ 1024) |
|--------|---------------|-------------------|---------------|
| **Weeks** | One column. Session cards turn into rows: thumbnail left, title + time right. Groceries button goes under the "Next week" heading. | 2-column card grid. | 3-column card grid: the default 3 sessions a week fill one row; more sessions wrap. |
| **Session sheet** | Bottom sheet, full width. Swap suggestions in a sideways-scrolling row. | Centred panel. | Centred panel. |
| **Card 1 · Overview** | One column: title, image, macros (4 × 2 grid), ingredients, you need / equipment / allergens. | Two columns, image smaller. | Two columns (as sketched). |
| **Card 2 · Cook** | Steps in one column, small photo above each. Ingredients move into a sheet: a sticky **Ingredients** button opens it over the steps. | Sidebar + 2 step columns. | Sidebar + 3 step columns (as sketched). |
| **Groceries** | One column. "Which recipes" moves to a second line under the item. Week + weeks selector wraps onto two lines. | Single list, max width ~720, centred. | Same as Tablet. A list reads better narrow than stretched. |
| **Pantry** | Chips wrap. | Chips wrap. | Chips wrap. |
| **Settings** | Labels above controls; food-group chips wrap. | Label column + controls (as sketched). | Same, max width ~720. |
| **Sign in** | Centred. | Centred. | Centred. |

### Phone: Weeks

```text
┌──────────────────────────────────────┐
│ Dinner Planner                    ⚙  │
├──────────────────────────────────────┤
│ THIS WEEK · 5 – 11 Oct               │
│ ┌──────┐ Chickpea Tikka Bowl      ⋯  │
│ │ img  │ 35 min · 2 portions         │
│ └──────┘                             │
│ ┌──────┐ Lemon Herb Salmon        ⋯  │
│ │ img  │ 25 min · 2 portions         │
│ └──────┘                             │
│ ┌──────┐ Black Bean Chilli        ⋯  │
│ │ img  │ 40 min · 2 portions         │
│ └──────┘                             │
│                                      │
│ NEXT WEEK · 12 – 18 Oct              │
│ Review before you shop               │
│ [ Groceries · 14 items            › ]│
│ ┌──────┐ Miso Noodle Soup            │
│ │ img  │ 20 min · 2 portions         │
│ └──────┘                             │
│ ...                                  │
├──────────────────────────────────────┤
│   [ ▦ Weeks ]      [ 🛒 Shopping ]   │
└──────────────────────────────────────┘
```

### Phone: Card 2 · Cook

```text
┌──────────────────────────────────────┐      ┌──────────────────────────────────────┐
│ ‹  Chickpea Tikka Bowl      ☀ Awake  │      │ ‹  Chickpea Tikka Bowl      ☀ Awake  │
│    [ Overview ]  [■ Cook ]           │      │    [ Overview ]  [■ Cook ]           │
├──────────────────────────────────────┤      ├──────────────────────────────────────┤
│ ┌──────────────────────────────────┐ │      │ 1 COOK RICE                          │
│ │          [ photo, short ]        │ │      │ Put the **rice** on to boil...       │
│ └──────────────────────────────────┘ │      ├──────────────────────────────────────┤
│ 1 COOK RICE                          │      │ INGREDIENTS · 2 portions          ✕  │
│ Put the **rice** on to boil with     │      │ Chickpeas                     1 tin  │
│ 300ml water...                       │      │ Red onion                         1  │
│                                      │      │ Baby spinach                    80g  │
│ ┌──────────────────────────────────┐ │      │ Basmati rice                   130g  │
│ │          [ photo, short ]        │ │      │ ...                                  │
│ └──────────────────────────────────┘ │      │ YOU NEED                             │
│ 2 PREP VEG                           │      │ Olive oil                    1 tbsp  │
│ Slice the **red onion**...           │      │ ...                                  │
│ ...                                  │      │                                      │
├──────────────────────────────────────┤      │                                      │
│        [ Ingredients · 7  ▲ ]        │      │                                      │
└──────────────────────────────────────┘      └──────────────────────────────────────┘
          steps (sheet closed)                      ingredients sheet open
```

- The **Ingredients** button stays at the bottom while you scroll the steps. Tapping it slides up
  a sheet with the sidebar's content; swipe down or ✕ to go back to the same step.
- Phone cooking is a fallback (the iPad is the main kitchen device), so a sheet is good enough here.

## Fewest-taps review

Every task from the journeys, counted from opening the app. Swipes count as taps. Ticks,
swaps, skips and moves never ask "are you sure?"; they show an Undo toast instead.

| Task | How often | Taps | Verdict / change |
|------|-----------|------|------------------|
| Cook one of this week's meals | 3×/week | 1 | ✓ Card → Overview. Wake lock is automatic. |
| Get to the steps | 3×/week | +1 | ✓ Swipe or "Cook". **Change:** reopening a recipe resumes the card and scroll position you left (e.g. after the app reloads mid-cook). |
| Open next week's review | weekly | 0–1 | **Change:** from **Friday** (review opens), Weeks shows a banner at the top: "Next week is ready to review ›". On iPad next week is visible anyway; on phone the banner saves a scroll. |
| Swap a meal | weekly | 2 | ✓ Meal → pick a suggestion. |
| Skip a meal | occasional | 2 | ✓ Meal (or `⋯`) → Skip. |
| Change portions | occasional | 2+ | ✓ Meal → `+`/`−`. |
| Move a meal to another week | rare | 3 | ✓ Meal → week picker → week. Rare enough. |
| Grocery list | weekly + in shop | 1 | ✓ Opens on the week you're shopping for. |
| Tick a grocery item | ~15×/week | 1 each | ✓ No confirm; moves to Got. |
| Bulk-buy view | monthly | 2 | ✓ Shopping → "3 weeks". |
| Mark a pantry staple as out | occasional, often mid-cook | 3 → **1** | **Change:** tap a "You need" item on Card 1 or Card 2 to mark it out (toast + Undo). The Pantry tab is still there for a full check. |
| Check groceries while prepping | weekly | 1 | ✓ Card 1 ticks mirror the grocery list. |
| Back to Weeks from a recipe | every cook | 1 | ✓ |
| First-run setup | once | 2 | ✓ Google → setup screen with defaults filled in → "Plan my dinners". |
| Change a setting | rare | 2+ | ✓ ⚙ → change (saves immediately) → popup on leaving. |
| Reminder → review (S4) | weekly | 1 | ✓ Notification opens next week's review directly. |

**Result:** every weekly task is 2 taps or fewer. Three changes: the review banner on Weeks,
marking pantry items out from the recipe, and resuming where you left off in a recipe.

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
S4 reminders → notification deep-links into next week's review; S5 bulk buy → Shopping › Groceries.

## Open questions
_None._
