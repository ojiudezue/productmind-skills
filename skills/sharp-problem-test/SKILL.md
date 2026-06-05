---
name: sharp-problem-test
description: Use when the user is evaluating whether a product or feature idea is worth building. Triggers on phrases like "is this a real problem", "should we build this", "is this worth pursuing", "evaluate this idea", "is the market big enough", or when the user pitches a product/feature without first stating the problem. Runs the 3-Question Sharpness Test from Ch 1 of Building Rocketships.
---

# Sharp Problem Test

## What this does

Runs Ch 1's 3-Question Sharpness Test on a stated problem or product idea.
Returns a verdict with the evidence for each axis, plus a go/no-go recommendation.

## When to use

Trigger when the user:

- Is evaluating a new product or feature idea
- Asks "is this worth building"
- Pitches a solution before establishing the problem
- Wants to compare two opportunities

## When NOT to use

- The user already has product-market fit and is past the validation stage
- The user is asking about pricing, design, or growth — those have their own skills
- The problem is already validated and the user is moving to execution

## The 3 questions (from Ch 1, pages 14-21)

1. **Alternatives** — What are the current alternatives? How are people duct-taping a
   solution? If a trivial alternative exists, the problem is not sharp.
2. **Prevalence** — How prevalent is the problem? Four sub-vectors:
   - Market size (how many people/companies experience it)
   - Problem growth (is it getting worse, or being solved by other tech)
   - Niche-ness (broad-based vs role-specific)
   - Frequency (rare / yearly / monthly / weekly / daily / multiple times daily)
3. **Value** — Are people (or their managers) willing to pay to solve it? Two ways
   to estimate: (a) what they spend on alternatives today, (b) time saved × hourly cost.

## The decision rule

The improvement bar is **≥3x** over the status quo workflow. Below that, customers
won't pay the switching costs. Some markets (super-computing, solar) have lower
bars; most B2B software has a 3-5x bar.

A sharp problem must pass all 3 questions. If any axis fails, the problem is not
sharp enough to build a company or feature on.

## Inputs

- A problem statement OR a product/feature pitch
- (Optional) the user's target customer description
- (Optional) named competitors or alternatives

## Output structure

```
## Sharpness Verdict: [SHARP | NOT SHARP | NEEDS MORE EVIDENCE]

### Question 1: Alternatives
[What the user said + what's missing + book reference]

### Question 2: Prevalence
- Market size: [analysis]
- Problem growth: [analysis]
- Niche-ness: [analysis]
- Frequency: [analysis]

### Question 3: Value
[Willingness to pay analysis]

### Improvement bar check
[Does the proposed solution offer ≥3x improvement over the current workflow?]

### Recommendation
[Concrete next step — either "proceed with this evidence" or "validate X before continuing"]

### Analogous case from the book
[1 named example from the book that parallels this situation]
```

## Worked examples from the book

### Example 1: Calendly's sharp problem (Ch 1, pages 16-18)

Problem: scheduling meetings with people outside your company.

- Alternatives: email back-and-forth (tedious, often fails)
- Prevalence: experienced by almost everyone, growing, high frequency for sales/recruiting/marketing roles
- Value: lost meetings = lost sales; managers care
- Verdict: SHARP. Calendly's defining problem.

### Example 2: Calendly's email-from-app feature (Ch 1, page 18)

Problem: emailing your Calendly link from within the Calendly app.

- Alternatives: copy/paste — totally viable
- Verdict: NOT SHARP. Useful feature, but not standalone justification for shipping.
The team only shipped it because it unlocked a sharp adjacent feature (automatic reminders).

## Gotchas

- **Don't accept the user's first answer on alternatives.** Most users undercount.
  Ask: "What do they do today, even if it's inefficient?" If they say "nothing,"
  the problem probably isn't real.
- **Frequency matters more than people think.** A daily problem can sustain a
  business at a fraction of the market size needed for a monthly one.
- **Growth direction is a hard filter.** A shrinking problem (e.g., FAX cover sheets)
  is a no even if currently prevalent.
- **The 3-5x rule isn't universal.** In saturated markets (super-computing, solar
  panel efficiency) much smaller gains matter. Ask about the market's gain-norm
  before applying the bar.

## Anti-patterns to flag

If the user's pitch has any of these, surface them:

- "We'll figure out the problem after we build" — refuse, run the test first
- "Everyone has this problem" — push for specifics on role, frequency, value
- "There's no competition" — usually means no market, not blue ocean

## Source

Ch 1: Customer Discovery: Identifying Sharp Problems, pages 14-23

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 1.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=sharp-problem-test)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-03
