---
name: listening-machine
description: Use when the user needs a customer feedback system or is debugging signal-to-noise in existing channels. Triggers on phrases like "customer feedback", "voice of customer", "VOC", "churn surveys", "feedback loop", "how do I listen at scale", "support is overwhelmed", "we're flying blind". Implements the Customer Listening Machine from Ch 2 of Building Rocketships.
---

# Customer Listening Machine

## What this does

Runs Ch 2's Customer Listening Machine framework. Returns a wiring
diagram for feedback channels in the user's tool stack, a triage SLA
defining who handles what within how long, and a first-month rollout
plan. Encodes the book's decision rule: prioritize signals that recur
across ≥2 channels.

## When to use

Trigger when the user:

- Has no formal feedback system and is "flying blind"
- Has feedback fragmented across Slack, Intercom, support tickets, CS
  notes — and can't tell what's actually a priority
- Is post-launch and needs to set up VOC infrastructure
- Has high churn but no idea why
- Wants to install churn surveys, NPS, or embedded feedback

## When NOT to use

- Pre-PMF / pre-launch — you have no users yet; run
  `customer-discovery-week` instead
- The problem is *single-channel* triage (e.g., "improve our support
  ticket workflow") — narrower than this skill
- The user is asking about quantitative North Star metrics — that's
  `vmsoop-strategy`

## The 4 channels (from Ch 2)

A complete listening machine has all four. Missing channels are
silent failure modes — you don't know what you're missing.

### 1. Embedded in-product feedback

A persistent, in-context way for users to report problems or
suggestions from inside the product (not a help page button buried
in a menu). Examples: contextual feedback widget, "send feedback"
shortcut, AI-assistant style "what's broken" prompt.

### 2. Churn surveys (100% capture)

Every churned customer triggers a survey asking why. Not optional,
not sampled — 100% capture. Even 3 responses per week build a
qualitative picture other channels miss.

### 3. Bi-directional CS sync

Customer Success / Support notes must flow both ways: into product
review meetings, AND product context flows back into CS. A
one-directional pipe (CS hears, product never responds) destroys
the signal.

### 4. Automated routing to product/eng

Critical signals (e.g., reported bugs, churn reasons, feature
requests recurring across channels) route automatically to Slack /
Jira / Linear with the source attached. Manual triage doesn't scale
past 1k users.

## The decision rule

**Prioritize signals that recur across ≥2 channels.** A single
channel surfaces noise. A signal that shows up in churn surveys AND
in support tickets AND in CS notes is real. Build for that signal.

## The triage SLA

Every signal needs an owner and a clock:

- **P0 (security, data loss, outage)**: < 1 hour, named on-call
- **P1 (broken core workflow)**: < 1 business day, named PM/EM
- **P2 (paper cuts, feature requests recurring)**: weekly product
  triage, batched
- **P3 (one-off ideas)**: monthly review, often archived without action

If you don't have these SLAs, the channels exist but the machine
doesn't run.

## Refusal mode

If the user proposes "we'll add NPS and call it done," refuse. NPS is
a single channel and a lagging score, not a listening machine.

If the user has channels but no triage SLA, the system is decorative,
not load-bearing. Flag the SLA gap as the blocker.

If the user has ≥3 channels with high volume but no automated
routing, recommend the routing FIRST — manual triage at scale
suppresses signal more than gathering more feedback does.

## Inputs

- Current tool stack (Slack, Intercom, Jira, Linear, Pendo, Mixpanel,
  etc.)
- Current channels in place (or "none")
- User volume tier (< 100, 100–1k, 1k–10k, > 10k)
- (Optional) current pain — "support is overwhelmed", "we don't know
  why people churn", etc.

## Output structure

```
## Listening machine verdict: [READY | GAPS | NEEDS_MORE_INPUT]

### Wiring diagram
1. Embedded feedback: [tool + how/where it's surfaced in-product]
2. Churn surveys: [tool + 100% capture mechanism]
3. Bi-directional CS sync: [tool + cadence]
4. Automated routing: [tool + rules]

### Triage SLA
| Priority | Owner | Clock | Cadence |
|---|---|---|---|
| P0 | ... | < 1h | as-it-happens |
| P1 | ... | < 1 day | daily |
| P2 | ... | weekly | weekly triage |
| P3 | ... | monthly | monthly review |

### First-month rollout plan
- Week 1: [setup]
- Week 2: [setup]
- Week 3: [first triage round]
- Week 4: [first cross-channel synthesis]

### Cross-channel rule
[How to identify a real signal: recurring across ≥2 channels]

### Recommendation
[Concrete next step — typically 'install the missing channel before adding nudges to existing ones']

### Analogous case from the book
[A named example]
```

## Worked example from the book

### Atlassian's listening machine (Ch 2)

- **Embedded in-product**: contextual feedback in every product
  surface, routed to specific squad inboxes
- **Churn surveys**: 100% capture via post-cancellation email; CS
  triages and tags by reason
- **Bi-directional CS sync**: weekly product+CS sync; product owners
  attend; CS gets a feedback channel back
- **Automated routing**: feedback widget feeds Jira tickets tagged by
  squad and customer tier
- **Triage SLA**: P1 < 24h, P2 weekly, P3 quarterly; named owners
- **Cross-channel synthesis**: monthly "voice of customer" digest
  showing signals that hit ≥2 channels

## Gotchas

- **NPS is not a listening machine.** It's one number from one
  channel. Use it as a lagging indicator, not the system.
- **CS notes that don't reach product = nothing was reported.** If
  the loop is broken at the bi-directional step, every other channel
  is degraded.
- **Don't add channels you can't triage.** A new feedback widget
  that floods an untriaged inbox is worse than no widget; users learn
  their feedback is ignored.
- **The cross-channel rule is the strongest filter.** Without it,
  every loud single-channel signal wins; the listening machine just
  surfaces the loudest people.

## Anti-patterns to flag

If the user's plan has any of these, surface them:

- "We'll just install Intercom and we'll be fine" — single channel,
  no triage; not a machine
- ≥3 channels but no automated routing — manual triage will suppress
  the real signal
- Churn surveys but not 100% capture — sampling bias destroys the
  picture
- Listening machine but no published SLA — owners don't know what
  they're on the hook for

## Source

Ch 2: The Customer Listening Machine.

---

## About this skill

This skill is part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)** catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Chapter 2.
This skill applies one named framework from the book. It works standalone in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** The **RocketshipsGPT agent** runs all 13 book skills together, with persistent memory, framework-fidelity evals, voice-checked output, and the book's anti-pattern catches built in. → [rocketshipsgpt.productmind.co](https://rocketshipsgpt.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=listening-machine)

**License:** Skill content licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivative works must share alike. See [ADR 0005](https://github.com/ojiudezue/BuildingRocketships/blob/main/docs/adr/0005-license-split.md) for rationale.

**Skill version:** 1.0.0 · **Published:** 2026-06-05
