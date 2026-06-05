---
name: vmsoop-strategy
description: Use when the user is defining or revisiting product strategy, North Star metrics, or objectives. Triggers on phrases like "strategy", "North Star", "OKRs", "vision and mission", "what metrics matter", "VMSOOP", "metrics hierarchy", "objectives", "priorities". Implements VMSOO-P + cascading Tier 1/Tier 2 metrics from Ch 7 and Ch 14 of Building Rocketships.
---

# VMSOO-P Strategy

## What this does

Runs the VMSOO-P framework plus the cascading Tier 1 / Tier 2 metrics
architecture. Returns a strategy document with the user's Vision,
Mission/North Star, Strategies (levers), Opportunity Costs,
Objectives, and Priorities — plus a North Star metric + 3 Tier-1
metrics + squad-level Tier-2 metrics, each with explicit math tracing
back to the North Star. Refuses to recommend mature metrics regimes
pre-PMF.

## When to use

Trigger when the user:

- Has no formal strategy doc and is making roadmap decisions ad hoc
- Has OKRs that don't ladder up to a North Star
- Is defining their first product strategy
- Is rewriting an existing strategy after a pivot
- Has Tier 1 metrics that no one looks at or that contradict each other

## When NOT to use

- Pre-PMF — strategy at pre-PMF means "sharpest problem to validate
  next"; use `sharp-problem-test` + `customer-discovery-week` instead
- User is asking about specific growth tactics — that's
  `growth-lever-picker`
- User is building a roadmap from existing strategy — that's
  `roadmap-from-strategy`

## VMSOO-P (from Ch 7 + Ch 14)

| Letter | Meaning |
|---|---|
| V | **Vision** — the world you're trying to create. 1-2 sentences, ambitious, time-unbound. |
| M | **Mission / North Star** — the measurable proxy for the vision. One number. |
| S | **Strategies** — the 2–4 levers you'll pull to move the North Star. |
| O | **Opportunity Costs** — what you are NOT doing. Explicit, named. |
| O | **Objectives** — 3–5 outcomes you'll hit this quarter or year. |
| P | **Priorities** — the ranked list of work that delivers the objectives. |

Every objective must trace to the North Star with **explicit math**:
"if we hit X, North Star moves by Y."

## North Star metric criteria (Ch 7)

A North Star must be **all five**:

1. **Customer-value** — measures something the customer values
   directly, not your revenue or activity
2. **Mission-tied** — moving it advances the mission
3. **Whole number, not relative** — "weekly bookings" not "booking
   growth %"
4. **Leading indicator** — moves before revenue, not after
5. **Controllable by the team** — the team's actions move it

Examples (book archetypes):

- Spotify: time spent listening
- Calendly: meetings booked through the platform
- Airbnb: nights stayed

## Cascading Tier 1 / Tier 2 metrics

- **Tier 1**: 3 metrics that, together, predict the North Star. Each
  Tier 1 lives at the executive level.
- **Tier 2**: squad-level metrics. Each squad owns ≤2 Tier 2 metrics
  that ladder to a Tier 1. Squads do NOT own Tier 1; they own their
  contribution to it.

If a squad cannot trace its Tier 2 to a specific Tier 1 to the North
Star with math, the metric should not exist.

## Refusal mode (the anti-pattern)

If the user is pre-PMF, refuse to design a mature North Star. The book
is explicit: pre-PMF, the only valid metric is "is this problem
sharp" and "are we learning faster." Mature North Stars at pre-PMF
optimize for the wrong thing.

If the user proposes a North Star that fails any of the 5 criteria,
refuse. The most common failure: revenue as the North Star. Revenue
is lagging and not customer-value; it goes in opportunity-cost or
operating metrics, not the North Star.

If Tier 1 metrics contradict each other (e.g., "increase signups" +
"increase activation rate"), flag the math: they can't both win
without changing the funnel; one is the actual goal and the other is
a guardrail.

## Inputs

- Stage: pre-PMF, post-PMF, growth, mature
- Product type and what customers value
- Existing OKRs / metrics, if any
- Strategic constraints (capital, team size, market)
- (Optional) the mission statement or vision draft

## Output structure

```
## Strategy verdict: [READY | DRAFT | NEEDS_MORE_INPUT]

### Vision
[1-2 sentences, ambitious, time-unbound]

### Mission / North Star
- Mission: [1-2 sentences tying vision to action]
- North Star metric: [the measurable proxy]
- 5-criteria check: customer-value [✓/✗], mission-tied [✓/✗], whole-number [✓/✗], leading [✓/✗], controllable [✓/✗]

### Strategies (levers)
1. [Lever 1]
2. [Lever 2]

### Opportunity Costs
- [What we are explicitly NOT doing and why]

### Objectives
1. [Objective + the math tracing to the North Star]
2. ...

### Priorities
1. [Ranked work item]
2. ...

### Cascading metrics
- North Star: [metric]
  - Tier 1A: [metric] — explanation
  - Tier 1B: [metric] — explanation
  - Tier 1C: [metric] — explanation
- Tier 2 (per squad):
  - Squad A: [≤2 metrics]
  - Squad B: ...

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's strategy (Ch 7 + Ch 14)

- **Vision**: a world without scheduling friction
- **Mission**: make every external meeting one-click
- **North Star**: meetings booked through Calendly per week
  (customer-value: a real meeting happened; whole number; leading;
  team controls activation, distribution, reliability)
- **Strategies**: viral free tier + integration ubiquity + enterprise
  admin
- **Opportunity Costs**: internal meeting scheduling (deferred);
  calendar-of-record replacement (out of scope)
- **Objectives**: grow weekly bookings 2x YoY; activation > 50%;
  enterprise ACV > $X
- **Tier 1**: weekly active schedulers; bookings per active scheduler;
  invite-to-booking conversion
- **Tier 2 (per squad)**: integrations squad owns invite-to-booking
  conversion via partner reliability; growth squad owns weekly active
  schedulers via referral loop

## Gotchas

- **Vision and Mission are different.** Vision is the world; Mission
  is what you'll do about it.
- **Strategies are levers, not features.** "Build a mobile app" is a
  priority, not a strategy. "Distribute through every workflow tool"
  is a strategy; mobile may be a priority under it.
- **If you can't name what you're NOT doing, you don't have a
  strategy.** Opportunity Costs are how you know strategy exists.
- **Each squad's Tier 2 should be 1-2 metrics, not 5.** More than 2
  means the squad is doing two jobs; split or reduce.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- North Star is revenue or signups — fail the 5-criteria; recommend
  a customer-value alternative
- Mature North Star applied pre-PMF — refuse; route to discovery
- Tier 1 metrics that don't ladder to the North Star with math — cut
- A strategy with no Opportunity Costs — recommend naming 2-3 things
  explicitly NOT being done

## Source

Ch 7: Strategy and the North Star. Ch 14: Cascading metrics.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 7.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=vmsoop-strategy)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
