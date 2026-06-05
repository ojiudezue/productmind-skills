---
name: customer-discovery-week
description: Use when the user is planning a customer discovery sprint to validate a sharp problem. Triggers on phrases like "how do I talk to customers", "plan a discovery week", "what should I ask", "interview script", "validate this problem", "discovery sprint", "customer research". Implements the 3-Step 1-Week Continuous Discovery process from Ch 1 of Building Rocketships.
---

# Customer Discovery Week

## What this does

Runs Ch 1's 3-Step 1-Week Continuous Discovery process. Returns a full
discovery plan: target interview cohort, two question scripts (motivation

+ workflow), a survey draft, a synthesis template, and a time budget for
the week. Refuses to recommend "discovery sprints" that skip interviews
in favor of surveys alone — the book's anti-pattern.

## When to use

Trigger when the user:

- Wants to validate a sharp problem (pairs with `sharp-problem-test`)
- Is pre-product, pre-PMF, or considering a new market
- Asks for an interview script or discovery plan
- Has a hypothesis and needs a structured way to test it in a week

## When NOT to use

- Problem is already validated and user is moving to execution — run
  `aha-mapper` or `slc-or-mvp` instead
- User wants to build a permanent feedback system — that's
  `listening-machine`
- User is asking about quantitative metrics / North Star — that's
  `vmsoop-strategy`

## The 3-step process (from Ch 1)

### Step 1 — Motivation interviews (5–10 calls)

Open-ended. Find out what the customer is trying to achieve, why it
matters now, and what their alternatives are. Avoid leading questions.
The goal is to understand the *job* behind the problem.

Key questions:

- Walk me through the last time you tried to solve [problem area]
- What did you try? Why?
- What was the outcome? How did it feel?
- What's the cost of NOT solving this?
- If a magic solution appeared, what would it do for you?

### Step 2 — Workflow interviews (5–10 calls)

Specific. Walk through the current workflow step by step. Identify the
target workflow (the one your product would replace), the **preceding**
workflow (what triggers it), and the **succeeding** workflow (what comes
after). The book's value-chain lens.

Key questions:

- Show me how you do this today, screen-share if possible
- What happens right before you start this?
- What do you do right after you finish?
- Where do you switch tools / context / role?
- What's the most painful step? Why?

### Step 3 — Survey (20–80 responses)

Quantify what the interviews surfaced. The survey is for prevalence
and intensity, not for discovering new things. Short (5–8 questions),
distributed to a target list (LinkedIn, community, customer base).

Key questions to include:

- How often does this happen? (frequency anchor)
- What did you try? (alternatives confirmation)
- How important is solving it on a 1–10 scale? (intensity)
- Would you pay to solve it? At roughly what level? (willingness)

## The synthesis template

After each step, write a one-pager:

- What we heard (verbatim quotes, 5+)
- What surprised us
- What confirms or contradicts the hypothesis
- What we need to ask in the next step

After all three steps, synthesize across into a single sharp-problem
hypothesis ready to feed `sharp-problem-test`.

## Time budget (1 week)

- Days 1–2: schedule + run motivation interviews
- Days 3–4: schedule + run workflow interviews
- Day 5: launch survey + start synthesis
- Day 6–7: collect survey results, complete synthesis, prepare verdict

## Refusal mode

If the user wants to skip interviews and run a survey only, refuse and
explain: surveys can quantify what interviews already surfaced, but
they cannot discover what to ask. Without interviews, the survey
questions encode the founder's biases, not the customer's reality.

If the user has fewer than 5 contacts available for interviews, flag —
under 5 is signal you don't have access to the market, which is its
own validation problem.

## Inputs

- The problem hypothesis to validate
- (Optional) target customer description (5-dimension or thin)
- (Optional) channels available for recruitment
- (Optional) any prior research already done

## Output structure

```
## Discovery plan verdict: [READY | NEEDS_MORE_INPUT]

### Target cohort
[Specific role + segment, sample size 5-10 for interviews, 20-80 for survey]

### Motivation interview script
[5-8 open questions in the order to ask them]

### Workflow interview script
[5-8 questions including the value-chain framing]

### Survey draft
[5-8 quantitative questions with answer choices]

### Synthesis template
[The one-pager structure to fill after each step]

### Time budget
[Day-by-day breakdown for 1 week]

### Recommendation
[Concrete next step — typically 'start scheduling day-1 interviews']

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly's pre-launch discovery (Ch 1)

- Cohort: 10 sales reps + 5 recruiters who scheduled 5+ external
  meetings per week
- Motivation: "What was the worst meeting-scheduling experience you've
  had recently?" — surfaced lost-pipeline stories from sales, no-show
  patterns from recruiting
- Workflow: shared screen during a typical scheduling pass — exposed
  the back-and-forth email loop and the spreadsheet-of-slots
  workaround
- Survey: 60 responses confirming daily frequency and quantified time
  cost (~5 hours/week per AE)
- Synthesis: ready hypothesis — "scheduling external meetings is a
  daily, painful, role-specific problem with a real cost"

## Gotchas

- **Stop hunting for new themes after interview 8–10.** If the next
  three interviews all confirm the same picture, you have enough.
- **Survey before interviews = noise.** The survey asks what
  interviews already told you. Reverse the order and the survey is
  the founder's hypothesis with extra steps.
- **Recruit from your real target, not your network.** Friends in
  adjacent roles will tell you what you want to hear.
- **Record the interviews (with consent) and quote verbatim.** The
  exact words matter — they're how you'll write copy that converts.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- "We'll send a survey and skip the interviews" — refuse; that's
  founder-bias confirmation
- "We don't know any potential customers" — research-access gap;
  recruit before running the sprint
- "We'll talk to 2 people" — too thin; need 5+ at minimum per
  interview step
- "We'll talk to current customers about a new product idea" — they
  are not the right cohort for the new problem; recruit fresh

## Source

Ch 1: Customer Discovery: Identifying Sharp Problems.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 1.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=customer-discovery-week)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
