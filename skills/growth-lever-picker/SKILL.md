---
name: growth-lever-picker
description: Use when the user is choosing which growth lever to pull next or building a growth roadmap. Triggers on phrases like "growth", "growth lever", "how do we grow", "ICE score", "growth experiments", "acquisition vs retention", "what should we focus on for growth", "growth portfolio". Implements the 10 Growth Levers + ICE framework from Ch 12 of Building Rocketships.
---

# Growth Lever Picker

## What this does

Runs Ch 12's 10-Lever Growth Framework. Scores candidate levers via
**ICE (Impact, Cost, Effort)**, returns a ranked shortlist, names the
opportunity costs of paths not taken, and enforces the 70/20/10
portfolio split (short-term / medium-term / exploratory). Refuses to
recommend levers the team cannot credibly execute given current
resources.

## When to use

Trigger when the user:

- Has a North Star + Tier 1 metrics defined (or `vmsoop-strategy` ran)
  and now needs to pick growth bets
- Is at the "we need to grow but don't know how" stage post-PMF
- Has 5+ candidate growth ideas and wants to prioritize
- Is debating acquisition vs. retention focus
- Needs a portfolio of bets, not a single lever

## When NOT to use

- Pre-PMF — growth before product-market fit accelerates churn; route
  to `sharp-problem-test` + `aha-mapper` first
- User wants a single experiment design — too narrow; this picks the
  bet to run
- User is building the roadmap from already-chosen levers — that's
  `roadmap-from-strategy`

## The 10 levers (from Ch 12)

### Reach levers (4) — bring more users to the product

1. **Paid acquisition** — ads, sponsorships, content syndication
2. **Organic content / SEO** — long-tail discovery
3. **Channel partnerships** — distribution via integrations,
   marketplaces, OEMs
4. **Referrals / virality** — existing users invite new ones

### Value levers (6) — make the product worth more to each user

5. **Activation** — % of signups who hit the aha (pairs with
   `aha-mapper`)
2. **Retention** — repeat use over time
3. **Expansion** — usage breadth (more workflows, more seats)
4. **Monetization** — pricing, packaging, tier moves
5. **Resurrection** — bringing dormant users back
6. **Reduced churn** — fewer cancellations

The book's running observation: most teams over-index on reach when
value levers are higher ICE. Reach without value is a leaky bucket.

## ICE scoring

Each lever gets three 1–10 scores:

- **Impact** — how much it moves the North Star if it works
- **Cost** — financial, time, opportunity cost (HIGHER = WORSE; the
  book inverts the conventional ICE so higher cost reduces score)
- **Effort** — how hard to execute (HIGHER = WORSE)

ICE = (Impact × 2) − Cost − Effort

The book weights Impact double because most growth failures are
high-effort small-impact work.

## The decision rule

**Pick the highest-ICE lever the team can credibly execute on with
current resources.** Credibility matters more than score: a top-scored
lever the team can't pull is worthless.

## Portfolio split (Ch 12)

The book is explicit on allocation:

- **70%** — short-term, high-confidence bets (3-month payoff)
- **20%** — medium-term bets (6–12 month payoff)
- **10%** — exploratory / 10x bets (12+ months, uncertain)

If the portfolio is 100% short-term, you'll plateau in 12 months. If
it's 50% exploratory, you'll run out of runway.

## Refusal mode

If the user is pre-PMF, refuse and route to discovery. Growth pre-PMF
accelerates the wrong thing.

If the user proposes a reach lever while activation < 30% or churn >
10% monthly, refuse — refer to the value-lever rationale. The leaky
bucket dominates.

If the team has no execution capability for the top-scored lever
(e.g., #1 is paid acquisition but no one on the team has run paid
campaigns), drop to the next viable option. Don't recommend the
fictional best.

## Inputs

- North Star metric + current value
- Current activation rate, retention, churn
- Available execution capabilities on the team
- 5+ candidate growth ideas (or "we don't know what to try")
- Budget / runway constraints

## Output structure

```
## Growth pick verdict: [READY | NEEDS_MORE_INPUT]

### Top 3 lever shortlist
| Rank | Lever | Impact | Cost | Effort | ICE | Credible? |
|---|---|---|---|---|---|---|
| 1 | ... | 9 | 3 | 4 | 11 | ✓ |

### Recommendation
[The single lever to execute first, with rationale]

### Portfolio allocation
- 70% short-term: [items]
- 20% medium-term: [items]
- 10% exploratory: [items]

### Opportunity costs (paths not taken)
- [Lever cut and the cost of cutting it]

### Sequencing
- Now: [...]
- Next 3 months: [...]
- 6-12 months: [...]

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's growth choice (Ch 12)

- Candidate levers: paid acquisition, SEO content, integration
  partnerships, referral loop, activation, retention
- ICE scores:
  - Referral loop (invitation is the product): Impact 9, Cost 2,
    Effort 3 → ICE 13
  - Integration partnerships: Impact 8, Cost 3, Effort 4 → ICE 9
  - Paid acquisition: Impact 7, Cost 8, Effort 5 → ICE 1
- Pick: referral loop — every meeting invitation introduces the
  brand to a new potential user; near-zero cost, embedded in the
  product use itself
- Portfolio:
  - 70% short-term: referral loop optimization, activation polish
  - 20% medium-term: top-3 integration partnerships
  - 10% exploratory: enterprise admin features

## Gotchas

- **Reach without value loses money.** If activation < 30%, fix
  activation BEFORE adding paid acquisition. Run `aha-mapper` if you
  haven't.
- **Credibility > raw ICE.** A 13-ICE lever the team can't execute is
  worth less than a 9-ICE lever they can.
- **Don't run 5 bets simultaneously.** Pick 1–2 short-term; one
  medium-term setup; one exploratory thread. More dilutes attention.
- **Re-score quarterly.** Effort drops as the team learns; impact
  changes as the market shifts.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- Heavy paid-acquisition spend with weak activation/retention —
  refuse, recommend the value lever first
- 100% short-term portfolio — name the medium-term gap
- 50% exploratory portfolio — name the runway risk
- "Let's just go viral" with no referral mechanism designed — recommend
  starting with the loop design, not the wish
- Same lever recommended for two consecutive quarters with no impact —
  drop, try the next

## Source

Ch 12: The 10 Growth Levers and ICE prioritization.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 12.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=growth-lever-picker)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
