---
name: scope-cutter
description: Use when the user is deciding what to cut from an onboarding flow, MVP scope, or feature list. Triggers on phrases like "cut scope", "what should we cut", "required vs optional", "progressive disclosure", "trim onboarding", "what's blocking activation", "the onboarding is too long". Implements the Required-vs-Helpful scope-cutting heuristics from Ch 3 and Ch 4 of Building Rocketships.
---

# Scope Cutter

## What this does

Runs Ch 3/4's Required-vs-Helpful scope cutting on an onboarding flow
or feature list. Returns a two-column allocation (Required vs Helpful)
with rationale per item, plus the progressive-disclosure nudge sequence
for everything that gets moved to Helpful. Targets the book's rule:
cut the required-onboarding list in half.

## When to use

Trigger when the user:

- Has an onboarding flow with more than 4–5 required steps
- Is shipping an SLC and needs to narrow scope (pairs with `slc-or-mvp`)
- Has a "required fields" list on a form longer than feels reasonable
- Is debating whether a feature belongs in v1 or v2
- Has measured activation drop-off concentrated in onboarding

## When NOT to use

- The user is asking about the aha moment itself — that's `aha-mapper`,
  which feeds this skill its definition of "required"
- The user is asking about tier feature segmentation (free vs paid) —
  that's `reverse-freemium-design`
- There IS no current scope to cut — this skill prunes, it doesn't
  generate; run `aha-mapper` first if no loop is defined

## The decision rule (from Ch 3/4)

For every item in the current required-onboarding list, ask:

> **If I removed this, would the user still hit the aha moment?**

- **Yes (they'd still hit it):** the item is **Helpful**, not Required.
  Move it out of the activation flow. Surface it later via progressive
  disclosure — empty-state nudge, contextual tooltip, dismissible
  banner after the first aha.
- **No (removing it blocks the aha):** the item is **Required**. Keep
  in onboarding, but verify it's the *minimum* version (one calendar
  not five, one event type not multiple).

The book's stronger heuristic: **cut the required list in half.** Most
PMs over-estimate what's required because every team owner argues
their thing belongs in the flow. Forcing a 50% cut surfaces what is
actually load-bearing.

## Progressive disclosure for Helpful items

Each item moved to Helpful needs a re-introduction plan, not just
deletion:

1. **First-aha trigger** — nudge appears right after the user
   completes the smallest loop once
2. **Contextual surface** — the nudge fires at the moment the user
   would benefit (when they create their second event type, prompt
   for default settings)
3. **Dismissible** — user can skip and the nudge doesn't reappear for
   that session
4. **Maximum 3 nudges per session** — beyond this is harassment

Items the user *never* taps after 5 sessions are candidates for the
"Surface only on user request" bucket (a settings menu, not a
proactive prompt).

## Refusal mode

If the user insists on keeping the full required list ("but every step
is important"), refuse to recommend the unchanged list and quantify the
cost: each additional required step costs roughly 5–15% of activations
in the book's running numbers. State the trade explicitly.

If items are being moved to Helpful but the user has no nudge plan,
flag this — moved-and-buried is not progressive disclosure, it's
hiding. Recommend the 4-element plan above.

## Inputs

- Current required-onboarding step list (or feature list to allocate)
- The defined aha moment + smallest loop (output of `aha-mapper` if
  available)
- Current activation funnel data, if any
- (Optional) feature owners who would object — the book's gotcha is
  internal politics

## Output structure

```
## Scope cut verdict: [HALVED | NEEDS_DEEPER_CUTS | NEEDS_MORE_EVIDENCE]

### Required (blocks the aha)
| Step | Why required | Minimum version |
|---|---|---|
| ... | ... | ... |

### Helpful (cut from onboarding, surfaced later)
| Step | Why cut | Re-surface trigger | Dismissible? |
|---|---|---|---|
| ... | ... | ... | ... |

### The cut
- Original required count: N
- Cut required count: M
- Reduction: ((N-M)/N)*100%

### Nudge sequence
[The 3-step post-aha surfacing plan for Helpful items]

### Expected activation impact
[1-2 sentences citing the book's 5-15%-per-step heuristic]

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's original onboarding (Ch 4) → cut from 8 to 3 required

Original required steps (the team had argued each was essential):

1. Sign up
2. Connect a calendar
3. Set default timezone
4. Configure default duration
5. Add a profile photo
6. Set buffer time between meetings
7. Create your first event type
8. Copy your share link

Cut to required:

1. Sign up
2. Connect a calendar
3. Copy your share link (a default event type is auto-created)

Moved to Helpful, surfaced after first booking:

- Default timezone (auto-detected from browser; nudge only if booking
  came in from a different zone)
- Default duration (nudged when user creates a second event type)
- Profile photo (banner in user dashboard, dismissible)
- Buffer time (advanced settings menu, not proactive)
- Multiple event types (nudged after first 3 bookings completed)

Result: cut from 8 required steps to 3. Activation rate roughly
doubled. The 5 moved items had no measurable activation impact when
removed.

## Gotchas

- **"Required" is a political negotiation, not a fact.** Every team
  feels their thing must be onboarded. Forcing a 50% cut surfaces who
  has data and who has feelings.
- **Moving to Helpful without a re-surface plan = burying the feature.**
  If you cut it and never bring it back, you've quietly killed it. Use
  the 4-element nudge plan or accept the kill.
- **The "minimum version" of a required step matters.** "Connect a
  calendar" is required, but "connect ALL calendars in your org" is
  not. Reduce each required step to its smallest viable version.
- **Auto-detection beats prompting for any field that can be inferred.**
  Timezone, locale, name — pull from browser/account, don't ask.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- Required-step list growing past 5 items — the book's running threshold;
  push back hard
- Required fields that have a sensible default (timezone, duration) —
  default and let users change later, don't block
- Moving items to "Optional in settings" without a proactive nudge plan
  — that's hiding, not disclosing
- Required onboarding step that doesn't appear in the smallest loop —
  by definition it's not required; the team has scope creep

## Source

Ch 3 (SLC scope cuts) and Ch 4 (Activation and the smallest loop).

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 3.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=scope-cutter)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
