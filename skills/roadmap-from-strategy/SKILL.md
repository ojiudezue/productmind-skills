---
name: roadmap-from-strategy
description: Use when the user is building, pruning, or rationalizing a roadmap. Triggers on phrases like "roadmap", "what should we build next", "prioritize the backlog", "KTLO", "feature list", "Q3 plan", "what's in v2", "quarterly planning". Implements the Problem-Ordered Roadmap framework from Ch 14 + Epilogue of Building Rocketships.
---

# Roadmap From Strategy

## What this does

Runs Ch 14 + Epilogue's Problem-Ordered Roadmap framework. Takes the
user's strategy (or `vmsoop-strategy` output) and a backlog, returns a
roadmap with items ordered by **sharp problem** (not feature), each
item carrying a customer story, capacity allocation across 80% new
build / 20% KTLO, and an explicit halt rule if KTLO drifts above 40%.
Refuses to recommend feature-list roadmaps with no traceability to
sharp problems.

## When to use

Trigger when the user:

- Has a backlog of features and needs to decide what to ship
- Is building a quarterly or annual plan
- Has a roadmap but it's just a feature list with no rationale
- Has KTLO debt eating into new work
- Wants to write a roadmap from a strategy that's already defined

## When NOT to use

- No strategy exists yet — run `vmsoop-strategy` first; a roadmap
  without strategy is a guess
- Pre-PMF — there is no roadmap pre-PMF; there is a discovery
  backlog; use `customer-discovery-week` and `sharp-problem-test`
- User wants to choose a single growth bet — that's
  `growth-lever-picker`

## The framework (from Ch 14 + Epilogue)

### Item shape

Every roadmap item has FOUR fields. Missing any one = not a roadmap
item, just a wish.

1. **Sharp problem** — the named customer problem this solves (cites
   `sharp-problem-test` output if available)
2. **Customer story** — the verbatim version of the problem from
   discovery
3. **Strategy linkage** — which strategy lever from VMSOO-P this
   pulls
4. **Success metric** — which Tier 1 or Tier 2 metric moves

### Ordering rule

Order by **sharp-problem priority**, not by effort or by who asked.
The book is explicit: "the easiest thing to ship is not the most
important thing to ship."

### Capacity allocation

- **80%** — new build (problem-solving)
- **20%** — KTLO (Keep The Lights On — performance, bug debt,
  infrastructure, compliance, security)

### The halt rule

**If KTLO drifts above 40% of capacity, halt all new features and
pay down debt.** Continuing past 40% accumulates compounding cost
and demoralizes the team.

40% is the book's hard line. Between 20% and 40%, the team gets a
warning and a paydown plan. Above 40%, no exceptions.

## Refusal mode

If the user provides a feature list with no strategy or sharp-problem
linkage, refuse to produce a roadmap. Return NEEDS_MORE_INPUT and
name the gap. Producing a "roadmap" from a feature list with no
problem trace is just rubber-stamping the wishlist.

If KTLO is reported above 40%, override the user's roadmap request
and recommend the paydown plan. The 40% line is non-negotiable.

If the strategy has no Opportunity Costs defined, the roadmap will
have nothing to cut and become bloated. Recommend running
`vmsoop-strategy` to surface them.

## Inputs

- Strategy summary (from `vmsoop-strategy` or written)
- North Star + Tier 1 metrics
- Current backlog or candidate items
- Current KTLO ratio (if known)
- Team capacity (engineer-weeks per quarter)
- (Optional) constraints — fixed deadlines, must-ship, etc.

## Output structure

```
## Roadmap verdict: [READY | NEEDS_MORE_INPUT | HALT_FOR_KTLO]

### Capacity allocation
- New build: ___% (target 80%)
- KTLO: ___% (target 20%, hard line 40%)
- If KTLO > 40%: halt and follow the paydown plan below

### Ordered roadmap
| Order | Item | Sharp Problem | Customer Story | Strategy Lever | Success Metric | Estimate |
|---|---|---|---|---|---|---|
| 1 | ... | ... | ... | ... | ... | ... |

### Items cut and why
- [Cut item] — [why, opportunity-cost rationale]

### KTLO paydown (if applicable)
- [Item + estimate]

### Quarterly milestones
- Q1: [items shipping]
- Q2: [items shipping]

### Recommendation
[Concrete next step — typically 'communicate the order to engineering with the stories attached']

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's roadmap (Ch 14)

- North Star: weekly bookings through the platform
- Strategy levers: viral free tier, integration ubiquity, enterprise
  admin
- Backlog: 24 features ranked by sharp-problem priority:
  - #1 — async meeting reminders (sharp problem: no-show rate;
    strategy: activation/retention; Tier 1: invite-to-booking
    conversion)
  - #2 — Zoom integration (sharp problem: bookers want video
    automatically; strategy: integration ubiquity; Tier 1: weekly
    active schedulers)
  - #3 — round-robin team scheduling (sharp problem: team-based
    scheduling friction; strategy: expansion; Tier 1: ACV)
  - ...
- KTLO budget: 20% (calendar API breakage handling, performance,
  security review)
- Cut: profile-photo customization (no sharp problem; opportunity
  cost: time better spent on Zoom integration)

## Gotchas

- **Feature lists are not roadmaps.** If your items don't cite a
  sharp problem and a customer story, you're shipping inventory, not
  strategy.
- **KTLO compounds.** A quarter of 30% KTLO becomes 40% the next
  quarter. The 40% halt rule exists because the math doesn't lie.
- **Effort-ordering is the easiest trap.** Doing the easy items
  first feels productive and accumulates technical debt and
  strategy debt simultaneously.
- **Customer stories must be verbatim.** Paraphrased customer stories
  become feature requests. Verbatim ones force you to honor the
  problem.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- Feature list with no sharp problem trace — refuse to call it a
  roadmap; route to `sharp-problem-test` for the backlog items
- KTLO > 40% but new features still on the plan — halt
- "Roadmap" ordered by who asked loudest — recommend re-ordering by
  sharp-problem priority
- No items cut from the backlog — opportunity-cost discipline missing;
  flag the strategy gap
- Six months of work that won't move any Tier 1 metric — re-prioritize
  or simplify the strategy

## Source

Ch 14: Roadmapping from strategy. Epilogue: The 80/20 build/KTLO rule.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 14.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=roadmap-from-strategy)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
