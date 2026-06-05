---
name: five-dim-customer
description: Use when the user needs to define a target customer beyond thin demographic personas. Triggers on phrases like "who is the customer", "define the persona", "target customer", "who are we building for", "ICP", "ideal customer profile", "buyer persona". Implements the 5-Dimension Target Customer framework from Ch 11 of Building Rocketships.
---

# Five-Dimension Target Customer

## What this does

Runs Ch 11's 5-Dimension Target Customer framework. Returns a customer
dossier across **Role, Persona, Objectives, Sharp Problems, JTBD +
Workflow**, plus the value-chain extension (preceding workflow +
succeeding workflow). Replaces thin demographic personas with a
structured definition that the rest of the agent's skills depend on.

## When to use

Trigger when the user:

- Has only a demographic persona ("VP Engineering, 100-500 employees")
  and needs a usable target customer
- Is shipping a new product or feature and needs to anchor it to a
  specific buyer
- Has multiple candidate segments and needs to choose one
- Is writing positioning, pricing, or roadmap and lacks a clear "who"

## When NOT to use

- User already has a defined target customer; jump to `sharp-problem-test`
  or `aha-mapper`
- User wants to discover the customer from scratch — run
  `customer-discovery-week` first to gather the raw material
- User is segmenting a quantitative cohort for analytics — different
  problem; this skill builds qualitative dossiers

## The 5 dimensions (from Ch 11)

### 1. Role

Job title plus the *organizational position* and *level of authority*.
"VP Engineering at a 200-person Series C company" is a role. "VP
Engineering" is a label.

### 2. Persona

Background, experience, what they value, how they think. The
behavioral and cognitive layer. Includes anti-persona — what this
customer is *not*.

### 3. Objectives

What this person is trying to achieve THIS QUARTER and THIS YEAR. Not
mission statements — concrete goals tied to their performance review,
team's roadmap, or company's stage. Surface 3–5.

### 4. Sharp Problems

The 1–3 sharp problems THIS role experiences, named in the customer's
words, with frequency and intensity. If you cannot name the sharp
problems, the role isn't a viable target — back up to
`customer-discovery-week`.

### 5. JTBD + Workflow

Jobs to be Done + the workflow that produces them. The JTBD frames
WHY the customer hires a solution; the workflow shows WHEN and HOW
the hiring decision happens. Include:

- The **target workflow** your product would replace
- The **preceding workflow** that triggers it
- The **succeeding workflow** that comes after

The preceding/succeeding extension is what separates this framework
from generic persona work. It surfaces the value-chain coupling that
makes integrations, distribution, and pricing decisions clear.

## The decision rule

A 5-dimension target customer is **COMPLETE** when:

- All 5 dimensions are populated with specifics, not generalities
- The Sharp Problems dimension has at least 1 problem the user could
  pass to `sharp-problem-test`
- The JTBD + Workflow includes both preceding AND succeeding
  workflows (not just the target one)

Anything less is **DRAFT**: the dossier exists but key fields are too
generic to use downstream.

## Refusal mode

If the user provides only a job title and demographics, return DRAFT
and name the missing dimensions. Refuse to fill them with plausible-
sounding fiction — the agent doesn't have access to the user's
customer interviews and must not invent objectives or problems.

If the user provides multiple plausible target customers, pick the
one with the sharpest problem and document why the others were
deprioritized — don't return a dossier per customer; the skill is
about choosing.

## Inputs

- Candidate role / segment (one or several to choose from)
- Any prior research, interviews, or quotes
- The product or product idea being built
- (Optional) constraints — must be enterprise, must be consumer, etc.

## Output structure

```
## 5-dimension verdict: [COMPLETE | DRAFT]

### Role
[Title + organizational position + authority level]

### Persona
[Background + values + thinking style + anti-persona]

### Objectives
- [Quarter / year objective 1]
- [Objective 2]
- [Objective 3]

### Sharp Problems
- [Problem 1 in customer's words + frequency + intensity]
- [Problem 2]

### JTBD + Workflow
- **JTBD**: [the job the customer hires a solution for]
- **Target workflow**: [the workflow your product replaces]
- **Preceding workflow**: [what triggers the target]
- **Succeeding workflow**: [what comes after]

### Coverage gaps
[Specific missing inputs, if any]

### Recommendation
[Concrete next step — typically 'pass Sharp Problem #1 to sharp-problem-test']

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's target — sales rep at mid-market SaaS (Ch 11)

- **Role**: Account Executive at a 50–500 employee SaaS company; quota-
  carrying; owns external pipeline
- **Persona**: 3–8 years sales experience; values speed over polish;
  comfortable with tools but not a tinkerer; anti-persona = inside-
  sales SDR (doesn't own the meeting)
- **Objectives**:
  - Q: hit 110% of quota
  - Y: convert pipeline 5pp faster than last year
- **Sharp Problems**:
  - "I lose 2-3 deals a month to scheduling friction" (~weekly, high
    intensity)
  - "My calendar is held hostage by anyone who can email me a meeting
    request" (~daily, moderate)
- **JTBD + Workflow**:
  - JTBD: "book the meeting before the prospect's interest cools"
  - Target workflow: external meeting scheduling
  - Preceding: cold outreach reply expressing interest
  - Succeeding: CRM update + prep notes

## Gotchas

- **"VP Engineering" is not a role; it's a title.** Add company stage,
  team size, what they own, what they don't.
- **Objectives must be time-bound.** "Hit quota" isn't an objective;
  "hit 110% of Q4 quota" is.
- **The succeeding workflow is the most-skipped dimension.** It's
  where integrations, exports, and analytics fit. Don't drop it.
- **Anti-persona is load-bearing.** Naming who this is NOT prevents
  the most common positioning failure: trying to serve everyone.

## Anti-patterns to flag

If the user's dossier has any of these, surface them:

- Only demographics, no behavior or workflow — that's a marketing
  persona, not a target customer
- Sharp Problems section is empty — refuse to call the dossier
  COMPLETE; route to `customer-discovery-week`
- Three+ dimensions filled with the founder's guess vs. customer
  quotes — flag the assumption risk
- "Our target is everyone" — return DRAFT and require a single
  primary

## Source

Ch 11: The 5-Dimension Target Customer.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 11.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=five-dim-customer)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
