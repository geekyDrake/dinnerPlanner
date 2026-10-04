# 001: Build a web app (PWA) instead of a native iOS app

**Status:** accepted
**Date:** 2026-10-04

## Context
The original plan was a native SwiftUI app for iPad/iPhone, distributed via the App Store,
with iCloud as the identity provider. Since then the spec settled on a **single user** (me)
with a **private recipe bank** gated server-side.

For a single user, native iOS has disproportionate costs:
- **Distribution:** any install that lasts longer than 7 days, and any iCloud/CloudKit use,
  needs the Apple Developer Program (~£80/yr, recurring). There's no sideloading equivalent
  to Android APKs outside the EU.
- **Toolchain:** current Xcode needs a macOS upgrade on my machine before any code runs.
- **App Review:** an app that is mostly empty for everyone but me risks rejection under the
  minimum-functionality rules, so we'd need a reviewer demo mode built only to satisfy review.

What the app actually needs from the platform: iPad-first responsive UI, screen kept awake
while cooking, reminders (notifications), and a backend that controls access to private data.

## Options
1. **Native SwiftUI + App Store.** Best iPad feel and the SwiftUI learning goal.
   Costs a recurring fee, a toolchain upgrade and App Review overhead, all for one user.
2. **Native SwiftUI, reinstalled from Xcode.** Free, but the install expires every 7 days and
   iCloud is unavailable. Not viable for daily use.
3. **Progressive web app (PWA).** Free hosting tiers, deploys in seconds, runs on any device,
   no review gate. Installed to the iPad home screen it gets standalone display,
   **Web Push** (iPadOS 16.4+) and the **Screen Wake Lock API**. Trade-offs: slightly less
   native feel, and push only works once installed to the home screen.
4. **Cross-platform (Flutter, React Native, Capacitor).** Native builds still need the developer
   account on iOS, so they don't fix the main constraint. Flutter *web* renders to a canvas:
   multi-MB first load, weaker text/accessibility and PWA support, and Dart instead of the
   web's own stack. More complexity than a single-user app needs.

## Decision
**Option 3: a PWA**, iPad-first and responsive across desktop, iPad and phone.

Main driver: it meets every v1 requirement with zero recurring platform cost and no
gatekeeper between a commit and my iPad. The private-data requirement is unaffected because
access control was always a backend concern (authenticate, then authorise by user ID),
not a property of the client.

## Consequences
- **Learning goal shifts** from SwiftUI to a modern web front-end (framework: ADR to follow).
  This is a deliberate trade: shipping and using the app beats the original learning goal.
- **Identity moves off iCloud** to standard web auth (e.g. passkeys or magic links). Recipe
  access stays allow-listed server-side; no secrets or unlock codes in client code.
- **Platform risks to test early (spike):** my iPad tops out at iPadOS 17, where the Wake Lock
  API is unreliable in home-screen web apps (fixed in 18.4). Plan: try Wake Lock, fall back
  to a muted looping video started by an explicit "Start cooking" tap. Also verify Web Push
  (16.4+) when the app is closed; if unreliable, reminders degrade to in-app prompts.
- **Simpler delivery:** CI deploys previews per branch; no signing, provisioning or review.
- **Reversible:** the backend/API is client-agnostic, and domain logic (scheduling, grocery
  maths) lives in plain TypeScript modules, so a future native client (Capacitor wrap or
  React Native) can reuse it without touching the data layer.
- **Revisit if:** the app gains other users, needs deep OS integration (e.g. HealthKit for
  the Apple Health stretch goal, which has no web API), or PWA support on iPadOS regresses.
