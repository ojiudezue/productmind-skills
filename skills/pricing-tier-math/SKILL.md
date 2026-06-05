---
name: pricing-tier-math
description: Use when the user is setting prices, designing tiers, or computing margin. Triggers on phrases like "pricing", "how should we price", "tiers", "price point", "what should it cost", "margin", "willingness to pay", "competitor pricing", "should this be an add-on". Implements the Cost-Margin-Tier Pricing framework from Ch 6 of Building Rocketships.
---

# Pricing Tier Math

## What this does

Runs Ch 6's Cost-Margin-Tier Pricing framework. Takes a cost basis,
target margin, and market anchors. Returns the calculated base price,
a 3-tier structure with feature assignment, and a decision on which
features belong as add-ons versus tier-bolsterers. Refuses to recommend
pricing schemes that drastically diverge from buyer expectations without
named justification.

## When to use

Trigger when the user:

- Is setting initial pricing for a new product or feature
- Is restructuring tiers (e.g., adding an Enterprise tier, splitting Pro)
- Asks "what should this cost"
- Asks "what should be an add-on vs in the tier"
- Is evaluating competitor pricing as an anchor
- Has cost data but no margin math

## When NOT to use

- The product is pre-PMF — pricing matters less than validating the
  problem. Use `sharp-problem-test` first.
- The user is asking about trial length or free-vs-paid segmentation —
  that's `reverse-freemium-design`, not this skill.
- The product is open-source or has no per-unit cost basis — this
  framework assumes a cost floor exists.

## The framework (from Ch 6)

### Step 1 — Cost floor

Compute the per-unit (or per-seat, per-month) cost to deliver the product.
Include:

- Infrastructure (compute, storage, bandwidth)
- Third-party APIs and data
- Support and success allocation
- Payment processing
- Allocated R&D for ongoing maintenance (not new build)

Be specific. "About $X" is not enough. Bottom-up the cost.

### Step 2 — Base price from target margin

The book's formula:

```
Base Price = Cost / (1 − Target Margin)
```

For most SaaS, target margin is **70%**, so:

```
Base Price = Cost / 0.30
```

For higher-touch / enterprise: 60% target.
For commodity / infrastructure: 50% target.

### Step 3 — Market anchor check

Find 2–4 competitors charging adjacent prices for comparable scope. The
base price you computed must land within the anchor range OR have a
named reason to deviate (e.g., 10x the value, branded premium, narrow
niche with no real competition).

If the cost-derived base price is far outside the anchor range, one of
two things is true:

- Your cost is wrong (too high → re-examine; too low → you're leaving
  margin on the table)
- The market won't bear the price you need to be profitable

The book is direct: if neither, the business model is broken. Don't
ship it.

### Step 4 — Tier construction (the 3-factor rule)

Tiers are built using three factors:

1. **Delivery cost** — features that materially cost more to deliver go
   in higher tiers (storage, compute, API quotas, SSO infrastructure)
2. **Customer value** — features that deliver more value to a specific
   buyer segment go in tiers priced for that segment
3. **Breadth of appeal** — features that almost everyone wants go in
   lower tiers to drive volume; features that only some want go in
   higher tiers or as add-ons

### The decision rule

**Niche features become add-ons.** Broad features bolster lower tiers.

If a feature has high cost AND niche appeal, it's an add-on, not a tier.
If a feature is broadly wanted but low cost, it bolsters Starter/Pro.
If a feature is broadly wanted and high cost, it bolsters Pro/Enterprise.
If a feature is niche AND low cost, free-tier sweetener or remove it.

## Inputs

- Cost basis (bottom-up per unit/seat/month, with itemized components)
- Target margin (%) — default 70 for SaaS, 60 for enterprise, 50 for
  commodity if user doesn't specify
- Market anchors — 2+ competitor prices for comparable scope
- Feature list to allocate across tiers
- (Optional) buyer-segment definitions

## Output structure

```
## Pricing math verdict: [SOUND | UNSOUND | NEEDS_MORE_EVIDENCE]

### Cost basis
- Total: $X per [unit/seat/month]
- Itemized: [breakdown]

### Margin math
- Target margin: N%
- Base price = $X / (1 − N/100) = $Y

### Market anchor check
- Anchors: [competitor: $Z for similar scope, ...]
- Position relative to anchors: [below/within/above range]
- Verdict: [base price fits / mispriced / market won't bear]

### Tier structure
| Tier | Price | Target buyer | Features | Rationale |
|---|---|---|---|---|
| Starter | $A | ... | ... | broad-appeal features at low cost |
| Pro | $B | ... | ... | scale + collaboration |
| Enterprise | $C (or "custom") | ... | ... | high-cost / high-control features |

### Add-ons (niche features)
- [Feature]: $D — niche appeal, high delivery cost, kept out of tiers

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's Pro pricing (Ch 6) → SOUND

- Cost basis: small per-user cost — calendar API calls, scheduling
  infrastructure, support — call it ~$2/user/month at scale.
- Target margin: 70% (standard SaaS).
- Base price = $2 / 0.30 ≈ $6.67/user/month.
- Market anchors: Acuity ~$14/user, Google Calendar enterprise ~$6/user,
  Microsoft Bookings ~$5–10/user — $8–$15 range.
- Actual Calendly Pro: $12/user/month — within the anchor range, above
  the cost-derived floor (so healthy margin), below the high anchor.
- Tier construction:
  - Free: one event type, unlimited 1:1 scheduling (broad appeal, low
    cost — drives volume and acquisition)
  - Pro $12: multiple event types, automated reminders, integrations
    (broad-appeal scale features bolstering the main paid tier)
  - Teams $16: round-robin, team analytics (collaboration-priced)
  - Enterprise: SSO, audit logs, custom retention (high-cost
    enterprise features, custom pricing)
- Verdict: SOUND. Cost-derived floor exists, anchored in market range,
  tiers respect the 3-factor rule.

## Gotchas

- **"Cost = AWS bill" is wrong.** Cost includes support load, payment
  fees, and allocated maintenance. Bottom-up.
- **Don't anchor to free competitors.** "Google Docs is free" isn't an
  anchor for a paid productivity tool — it's a different category.
- **70% margin isn't a rule, it's a heuristic.** Markets with strong
  network effects sustain 80%+ (Slack early). Commodity infrastructure
  is 40–50%. Verify against your category.
- **Price changes are expensive.** Get tier prices roughly right at
  launch; iterate the feature mix more than the dollar amounts.

## Anti-patterns to flag

If the user's design has any of these, surface them:

- "Cost was $0.50, target margin 99%, so we charge $50" — the math is
  mechanically right and strategically wrong. Anchor check will catch it.
- "Our competitor charges X, so we charge X − 20%" — race to the bottom
  unless you have a genuine cost or scope advantage.
- "Tiers based on usage tiers only" (e.g., 100/1000/10000 of widget) —
  loses feature differentiation; can become commodity pricing.
- Drastic divergence from buyer expectations — if your market expects
  per-seat and you ship per-API-call, the buyer objection alone will
  block deals. Note the deviation explicitly with named justification.

## Source

Ch 6: Pricing Tier Math.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 6.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=pricing-tier-math)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
