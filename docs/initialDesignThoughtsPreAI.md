# Dinner Planner App
## The 'what and why' of this project
**Goal:** I want this to be a full on dinner planner app that abstracts as much work as possible from the act of planning dinners indefinitely.
**Why:** to help me diet properly I need forward planning of my dinners. I've got a bank of recipes that I can choose from. I want to make the seleciton and grocery shopping prepatation process seamless, using AI to support my SwiftUI coding (I'm a backend engineer).

**What this app will be:**
- An iPad first citizen with iOS for iPhone compatibility app
- Will plan your meals for the foreseeable future with as much variety as possible. It will inform you what ingredients you need to buy short term (for 1-2 weeks in advance) as well as long term ingredients you will need long term like spices etc. This way you will be able to pick up the exact quantity of ingredients in advance without worrying about what you will be cooking. Thei Grocery List feature is a first party citizen feature - must get it right - use toast notifications
- It will have a history of what you have cooked so it avoids repeats as much as possible till it reaches the end of the meal bank, while allowing you to tailor the upcoming dinners based on a) maybe you're not feeling something this week b) do you want more vegetarian or non-veg food this week c) holidays
- It will prep dinners for 1 month in advance, while keeping this history stored per user (icloud user key or some linked bespoke email account)
- It will take into account food preferences (non-negotiables versus stuff you don't like so want less often but can still eat) as well as veg vs non-veg restrictions
- 3 or so meals per week (adjustable) for meal prepping. Has macros for calorie tracking - maybe integrate with Apple Health as a stretch goal?
- Enable swappable or skippable meals if I'm not feeling something today 

**Implementation details this app should have:**
- Downloadable from the App store for iOS and iPadOS
- Built in SwiftUI - avoid UIKit as much as possible
- A DB/Backend hosted in a free/cheap site (maybe firestore or vercel)
- iCloud integration - i.e. the user key will be your icloud account
- The app should stay on while instructions and meal lists are operating - i.e. no sleep while in use for these specific features

## Design Philosophy
- Simple but modern - not clunky or over the top
- As few taps as possible to get to what I want
- As few 'optional' extra features as possible i.e. avoid scope creep and keep it focused
- Light weight UI app for app size and speed -> use the backend and DB for handling the rest
- CLEAN CODE STRUCTURE - use crit.md or something during reviews to ensure compliance to SOLID principles
- Apart from the meal instruction pages I will work with Claude to develop a design

## Meal Instructions design
**Card 1:**

```text
┌────────────────────────┬─────────────────────────────────┐
│ Title                  │ Ingredients                     │
├────────────────────────┼─────────────────────────────────┤
│   Image                │   Short term ingredients        │
│                        │          .                      │
│                        │          .                      │
│                        │          .                      │
│                        │                                 │
├────────────────────────┤   Long term ingredients         │
│    Macros              │          .                      │
│                        │          .                      │
│                        │          .                      │
│                        │   Equipment                     │
└────────────────────────┴─────────────────────────────────┘
```

**Card 2:**

```text
┌─────────────────────────────┬────────────────────────────┐
│1                            │ 5                          │
│                             │                            │
├─────────────────────────────┼────────────────────────────┤
│2                            │ 6                          │
│                             │                            │
├─────────────────────────────┼────────────────────────────┤
│3                            │ 7                          │
│                             │                            │
├─────────────────────────────┼────────────────────────────┤
│4                            │ 8                          │
├─────────────────────────────┴────────────────────────────┤
│  Search bar... (ask questions)                           │
└──────────────────────────────────────────────────────────┘
```

## System Design
### Database
Key: unique id hash with table to connected icloud user id or future integrations like Google account etc.
Stores:
-> All meals with ingredients, instructions, linked images, macros, equipment etc. as separate tables - implement clean database approach with everything in it's own table with linked keys using linking tables
-> Upcoming meals per user and meal history per user
-> User details like preferences, settings etc. -> perhaps encrypted for user details?
-> Image stores on CDN??? Too expensive perhaps?

### Backend
Thin -> APIs provide bridge to DB
-> calculation of meal schedule
-> Unsure how to handle images/media
-> Don't need cache or too many system design optimisations as there are only going to be a few reads at a time - maybe serverless to avoid server warmup or hosting handles server handling so no kubernetes and server maintenance?
-> Scheduling pipeline job to run for all users on a given schedule to generate upcoming meals if needed - need some DB to keep track of time to handle job scheduling
-> The output of the job should be to a DB where we can alter the contents for the situation where the user wants to make adjustments to which meals they want or swapping meals or whatever

## Approach to building
1) Work with Claude to finalise what we will build without implementation specifics
2) Focus on UI design - how do we want this to work. Idon't want to involve figjam or something - a bit overkill. Then think about system design - what architecture will we need to create this and what alternative designs can we come up with
3) Implementation:
-> Iterate fast - use best DB principles that allow for a changing schema which is inevitable as we design
-> Implement a simple BE with dummy responses perhaps
-> UI - focus on design principles
4) QA Testing
-> Do QA testing alongside implementation and be thorough
-> Keep simple philosophy in mind as I go along
-> Get feedback
-> Design for ipad as first party citizen


