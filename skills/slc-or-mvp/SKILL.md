---
name: slc-or-mvp
description: Use when the user is deciding what kind of first version to ship. Triggers on phrases like "MVP", "should we build an MVP", "minimum viable", "what's the smallest thing", "first version", "ship vs learn", "scope down". Implements the SLC vs MVP decision framework from Ch 3 of Building Rocketships.
---

# SLC or MVP

## What this does

Runs Ch 3's SLC-vs-MVP decision framework. Returns a verdict on which kind
of first version to build, plus the scope cuts needed to actually get
there, plus what gets thrown away from each path. Refuses to recommend
shipping an MVP as if it were a customer product — that's the book's hard
anti-pattern.

## When to use

Trigger when the user:

- Is asking "what should the MVP be"
- Is debating whether to ship to customers or run a learning experiment
- Has a scope they can't finish and needs to decide what to drop
- Is pre-launch and unsure how polished v1 needs to be
- Is mid-build and the team is arguing about "is this good enough to ship"

## When NOT to use

- The product is already shipped and in market — use `aha-mapper` for
  activation issues, `scope-cutter` for feature pruning
- The problem hasn't been validated yet — run `sharp-problem-test` first;
  a fuzzy problem makes both MVP and SLC questions unanswerable
- The user is asking about pricing or tier structure — that's
  `pricing-tier-math`

## The two options (from Ch 3)

### MVP — Minimum Viable Product

**Purpose:** *learning*, not adoption. Tests a specific hypothesis about
problem, customer, or willingness to pay.

**Properties:**

- **Discardable.** No one will be heartbroken when it's deleted. No
  technical debt is being incurred to maintain it.
- **Narrow.** Tests one or two hypotheses, not a product.
- **Short-lived.** Days to weeks of build.
- **Often manual.** A landing page, a Figma click-through, a manual
  back-end pretending to be an algorithm, a concierge service.
- **Honest about its nature.** Users know it's an experiment, or you're
  collecting signal without claiming to deliver a product.

### SLC — Simple, Lovable, Complete

**Purpose:** *adoption*. Ships to customers as a real, smaller version
of the product.

**Properties:**

- **Simple** — narrowed to one workflow, not many. Smaller surface area.
- **Lovable** — quality is high in the slice that exists. Not "barely
  works"; actually delights inside the scope.
- **Complete** — the workflow it covers is end-to-end. Users can hit the
  aha moment without escape hatches or "coming soon" gaps.
- **Maintainable.** This codebase is going to grow, not be thrown away.

## The decision rule

| Question | Answer points to |
|---|---|
| Is the problem still being validated? | **MVP** |
| Are you shipping to win adoption / first revenue? | **SLC** |
| Are users expected to fall in love with this? | **SLC** |
| Are you OK if no one keeps using it? | **MVP** |
| Will you delete this code in 3 months? | **MVP** |
| Will you build the v2 by extending this? | **SLC** |

If the answers split, pick **SLC**. Most "MVPs" should have been SLCs —
the book's running observation. The cost of a real shipped product is
higher, but the option value of users actually adopting is much higher.

## Refusal mode

If the user says "MVP" but the answers point to SLC (paying users
expected, will build the v2 from this code), refuse to call it an MVP.
Recommend SLC and name the additional scope cuts needed to get there.
The "MVP-shipped-as-product" anti-pattern is the most common failure
mode in the book — customers form expectations, the team incurs debt to
maintain throwaway code, and discarding the experiment is no longer
politically possible.

## Inputs

- The product or feature in question
- Current scope (features being considered)
- The stage: pre-validation, pre-launch, post-launch
- Who the users will be (paying customers vs. friendly test users)
- The hypothesis being tested (if it's truly MVP territory)

## Output structure

```
## Verdict: [MVP | SLC | NEEDS_MORE_EVIDENCE]

### Reasoning
[Which decision-rule signals point which way + how they weigh]

### Scope cuts to reach the recommended path
- Cut: [feature] — [why]
- Cut: [feature] — [why]

### What gets thrown away (MVP path) OR What stays in (SLC path)
[Specific list]

### Acceptance criteria
[How you'll know v1 is done]

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked examples from the book

### Calendly v1 (Ch 3) → SLC

- Simple: one event type, one calendar, one share link. Not "all
  scheduling needs."
- Lovable: the booking flow felt magical — paste link, recipient picks
  a slot, done. No friction.
- Complete: the workflow ran end-to-end. No "coming soon" gaps in the
  core path.
- Verdict: SLC, not MVP. Tope shipped a product, not an experiment.

### A typical landing-page test → MVP

- Discardable: no one is hurt when the page comes down
- Tests a hypothesis: "will people give us their email for this
  promise?"
- Manual back-end: spreadsheet of waitlist, no real product behind it
- Verdict: MVP, correctly scoped.

## Gotchas

- **"MVP" used as cover for "we don't want to invest in quality."** Most
  shipped MVPs are actually under-built SLCs. Customers showed up and
  got a bad experience; the team learned the wrong lesson ("users don't
  want this" when the truth is "users wouldn't tolerate THIS version").
- **SLC creep — the team turns SLC into "v1.0 final."** SLC means
  *Simple* + Lovable + Complete. If the scope keeps expanding to add
  every nice-to-have, you've lost the S. Re-cut.
- **An MVP that secretly aspires to be a product.** If you find yourself
  picking React, setting up CI, and writing tests for what you said was
  an MVP, it's an SLC pretending to be an MVP. Either commit to SLC and
  raise the bar, or strip back to true MVP scope.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- "MVP" but customers are paying for it — call it SLC and raise the bar
- "MVP" but the team will extend this codebase in v2 — call it SLC
- SLC but the workflow has "coming soon" gaps — it's not Complete; cut
  scope until it is
- SLC but quality in the existing slice is sloppy — it's not Lovable;
  invest in polish on the narrow scope before adding more

## Source

Ch 3: SLC or MVP.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 3.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=slc-or-mvp)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
