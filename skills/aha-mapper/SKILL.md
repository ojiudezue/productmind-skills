---
name: aha-mapper
description: Use when the user is designing activation, onboarding, or the free tier of a product. Triggers on phrases like "aha moment", "activation", "onboarding", "first-run experience", "what should be free", "free tier scope", "what's the smallest loop", "cold-start UX". Implements the Aha-Moment Smallest Loop framework from Ch 4 of Building Rocketships.
---

# Aha Mapper

## What this does

Runs Ch 4's Aha-Moment Smallest Loop framework. Identifies the smallest
end-to-end loop that delivers the core value, anchored to the behavior
of activated customers (the 80–90th percentile). Returns an aha
statement, the smallest-loop spec, activation acceptance criteria, and
the cognitive-orientation script the user needs to enter the loop.
Refuses to recommend designs where the free tier paywalls any step of
the loop.

## When to use

Trigger when the user:

- Is designing activation or first-run UX
- Is deciding what belongs in the free tier
- Has high signup-to-activation drop-off
- Is choosing what the empty state should do
- Is asking "what's the smallest version of this that still delivers
  value"

## When NOT to use

- The product has no activated users yet — you can't observe an 80–90th
  percentile loop until people have moved through one; run
  `customer-discovery-week` and the `sharp-problem-test` first
- The user is asking about pricing tiers — that's `pricing-tier-math`
- The user is asking about trial design — that's
  `reverse-freemium-design`
- The user is asking how to onboard a specific feature — too narrow;
  this skill is for the aha loop, not feature tutorials

## The framework (from Ch 4)

### Step 1 — Find the actual aha moment from behavior

Look at the 80–90th percentile of *activated* customers — not all
signups, just the ones who came back. What action(s) did they all
perform within their first session or two that the inactive cohort did
not?

That action is the aha. Not what marketing says it is. Not what the
founder wants it to be. What activated users actually did.

Examples (the book's archetypes, paraphrased):

- Slack: sent N messages in M channels
- Calendly: created a link AND someone booked through it
- Dropbox: installed on a second device

### Step 2 — Trace the smallest loop to that aha

Working backward from the aha action, what is the minimum sequence of
steps required? Every step that ISN'T required to reach the aha is
optional and should be moved out of activation (see `scope-cutter`).

The smallest loop has three properties:

- **End-to-end** — produces a meaningful outcome, not a checkpoint
- **Repeatable** — the second time through is faster, not the same
  fixed-cost onboarding
- **Self-sustaining** — completing once creates an incentive (and the
  capability) to complete again

### Step 3 — Cognitive orientation

What mental model does the user need to *enter* the loop? Most
activation failures are not "the UI is bad"; they're "the user doesn't
know what this is for." A 30-second cognitive-orientation script
(empty-state copy, a 3-line tooltip, a single animated example) closes
the gap.

### Step 4 — Acceptance criteria

- **Time to first aha**: median activated user hits the aha within N
  minutes of signup. The book argues for sub-10-minute for most SaaS.
- **Activation rate**: % of signups who complete the loop at least once
  in the first session
- **Repeat rate**: % of first-loop completers who complete it again
  within their first week

## The decision rule

**Free tier must allow the entire aha loop, end-to-end, at limited
scale. Nothing in the aha loop is paywalled.**

This is non-negotiable in the book. A free user must be able to reach
the aha without a paywall, a credit card, or an enterprise sales call.
Limits are fine (volume, integrations, advanced configuration); blocks
on the aha loop itself are not.

## Refusal mode

If the user describes a design where any step of the aha loop is
paywalled, gated, or blocked, return UNSOUND with the gap named.
"Free up to step 4, pay at step 5 to actually see the result" is the
classic anti-pattern. Refuse to recommend it. This pairs with the
paywalled-final-step rule in `reverse-freemium-design`.

## Inputs

- The product or feature
- What activated customers actually do (or current best guess)
- Current activation funnel data, if any
- Current free-tier vs paid-tier feature split

## Output structure

```
## Aha map verdict: [SOUND | UNSOUND | NEEDS_MORE_EVIDENCE]

### Aha moment
[One sentence — the actual action that signals 'this user is activated']

### Smallest loop
1. [Step]
2. [Step]
3. [Step]
[Each step has the user input, the system response, and the time budget]

### Cognitive orientation
[The 30-second script — empty-state copy, single example, mental model]

### Acceptance criteria
- Time to first aha (median): N minutes
- Activation rate target: %
- Repeat-within-7-days target: %

### Free tier completes the loop?
[yes/no, with the named blockers if no]

### Recommendation
[Concrete next step]

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Calendly (Ch 4) → SOUND

- **Aha moment:** someone successfully booked a meeting through your
  link without back-and-forth email.
- **Smallest loop:**
  1. Sign up + connect 1 calendar (~2 minutes)
  2. Create 1 event type with default settings (~30 seconds)
  3. Copy share link (~5 seconds)
  4. Recipient picks a slot and booking confirms (out of band, but
     completes the loop)
- **Cognitive orientation:** "Paste this link in your email signature
  or DMs. When people click it, they pick a time from your real
  calendar. No more back-and-forth."
- **Acceptance criteria:** activation = first inbound booking. Median
  time-to-aha around 5 minutes (signup + first link copy + first
  recipient action — the last step is what makes it real).
- **Free tier:** completes the loop fully. Free users can copy links,
  receive bookings, and use the core scheduling workflow forever.
- Verdict: SOUND. The defining example.

## Gotchas

- **The aha isn't what marketing says.** The brand promise ("save time
  on scheduling") is not the aha. The aha is the moment the user
  *experiences* the brand promise once. Look at behavior, not copy.
- **The smallest loop isn't a tutorial.** A guided tour walking users
  through 17 features is NOT the smallest loop. The smallest loop is
  the user doing one real thing.
- **"Activation" without a repeat rate is vanity.** A 90% activation
  rate where 5% return next week is worse than a 40% activation rate
  where 30% return. Measure the repeat too.
- **Cognitive orientation beats UI polish for activation.** Most
  activation problems are "the user doesn't know what this is for,"
  not "the buttons are ugly." Fix the script before redesigning the
  flow.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- "Free trial of the aha loop, paid version of the aha loop" — refuse;
  the aha must be free-tier accessible at limited scale
- Onboarding tour of 8+ steps — almost certainly not the smallest loop;
  run `scope-cutter` on the required-step list
- Activation measured by signup completion alone — meaningless; add a
  behavioral milestone (the actual aha action)
- "We don't know what the aha is" — research gap; identify it before
  designing activation

## Source

Ch 4: The Aha Moment and the Smallest Loop.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 4.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=aha-mapper)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
