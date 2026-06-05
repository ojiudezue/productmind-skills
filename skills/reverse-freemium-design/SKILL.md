---
name: reverse-freemium-design
description: Use when the user is designing a trial, freemium tier, or PLG conversion flow. Triggers on phrases like "trial length", "freemium", "PLG", "free tier", "what should be paid", "convert free users", "trial conversion", "paywall", "how long should the trial be". Implements the 4-element Reverse Freemium Design framework from Ch 5 of Building Rocketships.
---

# Reverse Freemium Design

## What this does

Runs Ch 5's 4-element Reverse Freemium Design framework on a product or trial
configuration. Returns a recommended trial length tied to usage frequency,
a free-vs-paid feature segmentation, an end-of-trial communication plan,
and a post-trial retention plan. Refuses to recommend paywalling the final
step of the core workflow — the book's hard anti-pattern.

## When to use

Trigger when the user:

- Is designing a freemium or trial-to-paid conversion flow
- Asks "how long should the trial be"
- Asks "what should be free vs paid"
- Is shipping a PLG (product-led growth) product
- Is reconsidering an existing pricing/freemium model that isn't converting

## When NOT to use

- The product is pre-PMF and there is no working core workflow yet — run
  `sharp-problem-test` and `aha-mapper` first
- The product is enterprise sales-led with no self-serve trial — Ch 5's
  framework doesn't apply; sales trials in a PLG market are a separate
  anti-pattern
- The user is asking about absolute pricing (dollar amounts) — that's
  `pricing-tier-math`, not this skill

## The 4 elements (from Ch 5)

### 1. Trial length tied to usage frequency

The book's table — the more often a customer uses the product, the shorter
the trial needs to be to demonstrate value:

| Usage frequency | Recommended trial |
|---|---|
| 4× per month or less | 30 days |
| 1–2× per week | 20 days |
| 3–5× per week | 14 days |
| 5–7× per week | 10 days |
| Daily or multiple times per day | 7 days |

The logic: trial length must be long enough for the user to hit the aha
moment AND form a habit. Daily-use products form habits in a week. Monthly-
use products need a full cycle.

### 2. End-of-trial messaging

A specific, dated, no-surprise communication sequence. Touchpoints at:

- Trial start (welcome + the path to aha)
- Mid-trial (usage check-in + nudges to the unused activation steps)
- 3 days before end (price + value reminder + frictionless upgrade path)
- Day of end (last call + graceful downgrade option)

No silent expirations. No surprise charges. The book is explicit: surprise
billing destroys trust permanently.

### 3. Free-tier feature segmentation

**Decision rule:** the free tier MUST complete the core workflow end-to-end.
The paid tier delivers scale, collaboration, or advanced configuration on
top of that workflow — never IN it.

Concretely:

- **Free** = the smallest loop that delivers the aha moment, runnable
  forever, at limited scale
- **Paid** = higher limits (more users, more storage, more runs), team
  features (sharing, admin, SSO), or advanced configs (custom domains,
  API access, integrations)

If you cannot describe the free tier as "completes the core workflow at
limited scale," you have not segmented correctly.

### 4. Post-trial retention

When a trial ends without conversion, the framework says: drop the user to
the free tier, not to nothing. The user who didn't convert this month may
convert in 3 months when their usage grows. Cutting them off entirely
destroys that path.

If your product has no free tier (true trial-only), the post-trial state
is "read-only access to what they created during trial" — never a hard
delete of their data.

## The decision rule

A reverse-freemium design passes if all four:

1. Trial length matches the usage frequency table (±20%)
2. End-of-trial messaging has at least the 4 named touchpoints
3. Free tier completes the core workflow at limited scale; nothing in the
   core loop is paywalled
4. Post-trial retention preserves user state and offers a free-tier landing

If any axis fails, the design is broken — name which and how to fix it.

## Inputs

- Usage frequency (the user's estimate or measured data)
- The named core workflow (output from `aha-mapper` if available)
- Proposed or existing free/paid feature split
- (Optional) competitor freemium models for anchoring

## Output structure

```
## Trial design verdict: [SOUND | UNSOUND | NEEDS_MORE_EVIDENCE]

### Usage frequency
[Measured or estimated frequency + which row of the table applies]

### Recommended trial length
[N days, per the table, with explicit justification if deviating]

### Free tier
- Completes core workflow: [yes/no, with the named workflow]
- Features: [list]
- Limits: [list — the throttles that drive upgrade]

### Paid tier
- Scale features: [list]
- Collaboration features: [list]
- Advanced configs: [list]

### End-of-trial messaging
[The 4 touchpoints with copy direction]

### Post-trial retention
[What happens on day N+1 if no upgrade]

### Anti-pattern check
[Whether the free tier paywalls any step of the core workflow]

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly (Ch 5) → SOUND

- Usage frequency: 3–5× per week for sales/recruiting roles
- Trial length: 14-day Pro trial — matches the table
- Free tier: book one event type, schedule unlimited 1:1s with a single
  calendar. Completes the core scheduling workflow end-to-end.
- Paid tier: multiple event types, team scheduling, automated reminders,
  workflows, integrations. Delivers scale + collaboration + advanced
  configs on top of the working free workflow.
- End-of-trial: reminder at day 11, last call at day 14, frictionless
  downgrade to free.
- Post-trial: full free-tier access preserved; no data deletion.
- Anti-pattern check: free tier does NOT paywall the final scheduling
  step. A free user can fully book meetings end-to-end.
- Verdict: SOUND. The defining example of the framework.

## Gotchas

- **Don't trust the user's self-reported frequency.** Ask for data. Most
  "daily" products are actually 3–5× per week when measured.
- **The trial-length table is not optional.** Calendly tried 30-day trials
  early on; conversion dropped because the urgency vanished. The lengths
  in the table are calibrated to habit formation, not generosity.
- **"Free for 14 days" is NOT a free tier.** A free tier is forever-free at
  limited scale. A 14-day trial that ends is a trial, not a free tier.
  Most products need both.
- **Drop-to-free, not drop-to-locked.** The retention math says some users
  convert in month 6, not month 1. Locking them out costs you those.

## Anti-patterns to flag

If the user's design has any of these, surface them and refuse:

- "Free until you actually try to ship/save/export/share" — the paywalled-
  final-step anti-pattern. The book is explicit: refuse this. Cite Ch 5.
- "30-day trial for a daily product" — too long. Urgency vanishes.
- "7-day trial for a monthly product" — too short. User never hits a full
  usage cycle.
- "No free tier, just trial-then-paid" — possible in some markets but the
  default in PLG is freemium. Push back unless the market is genuinely
  trial-only (single-purchase software, narrow vertical SaaS).
- Sales trials in a PLG market — separate anti-pattern from CLAUDE.md.

## Source

Ch 5: Reverse Freemium Design.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 5.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=reverse-freemium-design)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
