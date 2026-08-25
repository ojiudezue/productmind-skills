---
name: vet-a-feature
description: Use when the user is deciding whether to build a NEW FEATURE on an EXISTING product (not start a new project). Triggers on "should we build this feature", "vet this feature", "is this feature worth building", "prioritize this feature", "build or skip", or when a PM/founder pitches a feature for a product that already has users. Runs a composite feature-gate built from Building Rocketships (Ch 1, 3, 4, 5, 7): the sharpness ≥3x test, the sharpness×ease 2x2, strategy-fit, aha/activation fit, SLC/MVP scoping, and the book's anti-pattern refusals.
---

# Vet a Feature

## What this does

Vets a single **proposed feature on an existing product** and returns a
**BUILD / BUILD_SMALLER / PARK / SCRAP / NEEDS_MORE_INPUT** verdict, the smallest
version worth shipping, a success metric, and a recommendation — with **per-dimension
confidence** that degrades gracefully when inputs are thin.

This is the brownfield counterpart to `new-project-scaffolding`: the product,
customers, strategy, and activation loop already exist. You **ingest** that context
and judge a feature against it — you don't create it.

## When to use

- A PM or founder is deciding whether to build a specific feature
- "Should we build X?" / "Is this worth it?" / "Prioritize these features"
- A feature is proposed for a product that already ships to users

Do **not** use for whole new products (use `new-project-scaffolding`) or for a bare
problem with no proposed feature (use `sharp-problem-test`).

## Inputs — use only as much as you have

One hard gate, then graceful degradation. Ask for the gate; accept whatever else exists.

| Tier | Input | If missing |
|---|---|---|
| **Required (gate)** | the feature · the problem it solves · roughly who it's for | **Refuse** → `NEEDS_MORE_INPUT` |
| **Recommended** | product strategy / North Star · current aha/activation loop · other features in flight or shipped | run, **lower the relevant dimension's confidence** |
| **Optional** | effort/codebase signal · pricing context · current metrics · is-this-a-new-market | fall back to estimate; stamp confidence LOW |

The 2×2 is **comparative** — without peer features its placement is low-confidence.
Codebase is never required (most PMs don't have it); it only sharpens the ease axis.
Always tell the user the cost of what they didn't give you (`missing_inputs`), and
prefer a low-confidence real verdict over refusing. See `references/confidence-model.md`.

## The gate (run in order)

1. **Sharpness — the ≥3x bar.** Run the 3-question test on the feature's problem
   (alternatives / prevalence / value). Trivial workaround ⇒ not sharp. Must clear
   ≥3x improvement (B2B floor). → `references/sharp-problem-3x.md`
2. **Sharpness × ease 2×2.** Place it: build-now / build-alongside / long-term-moat /
   **scrap**. "Ease" includes go-to-market, not just engineering.
   → `references/two-by-two-rubric.md`
3. **Strategy fit.** Apparent line-of-sight to mission/North Star? No linkage ⇒ fails.
   No strategy given ⇒ `unknown` (don't invent one).
4. **Aha / activation fit.** Does it advance the product's activation loop, or is it
   orthogonal? (Orthogonal isn't fatal — note it.)
5. **Smallest version.** SLC (ship) vs MVP (learn); halve the required steps ("be
   brutal"); name the smallest activating loop.
6. **Anti-patterns — refuse outright.** Paywalling the final step of the core workflow,
   email/PII as primary ID, mature metrics on a pre-PMF feature, sales trials in PLG.
   → `references/anti-patterns.md`
7. **Success metric.** One leading-indicator value metric — with pre-PMF leniency
   (don't bolt a mature North Star onto a new incubation).

## Decision rule

- **BUILD** — sharp, build-now, strategy-fits, aha-advancing, no refuse-level
  anti-pattern, scope already near-minimal.
- **BUILD_SMALLER** — passes, but scope is too big → ship the SLC / smallest loop first.
- **PARK** — sharp-but-hard (moat), or strategy-fit unknown and load-bearing, or
  salvageable only by removing an anti-pattern. Revisit on a named trigger.
- **SCRAP** — low-sharpness-and-hard, no strategy linkage, or a refuse-level anti-pattern
  that guts it.
- **NEEDS_MORE_INPUT** — Tier-1 too thin to assess even at low confidence (use sparingly).

> Precedent (Ch 1, p18): Calendly **refused** "email your link from inside the app" —
> trivial copy/paste workaround. They shipped it only because it unlocked a sharp
> adjacent feature (reminders). A non-sharp feature can earn PARK/BUILD_SMALLER **if** it
> demonstrably unlocks a sharp one — say so explicitly.

## Outputs

**Always:** the structured verdict (verdict · overall + per-dimension confidence ·
sharpness · 2×2 placement · strategy_fit · aha_fit · anti_patterns_tripped ·
smallest_version · success_metric · missing_inputs · recommendation).

**If it passes (BUILD / BUILD_SMALLER):** scaffold the feature's doc trail —

- a **Feature Decision Record** (verdict + 2×2 + reasoning + revisit trigger) →
  `references/feature-decision-record.md`
- a **Feature Brief** (problem / target / smallest version / success metric / what it's NOT)
  → `references/feature-brief.md`
- an experiment-or-SLC plan.

PARK/SCRAP produce just the decision record (why + what would change the call).

## Composes (when available)

If the RocketshipsGPT MCP tools are present, delegate the sub-checks to
`sharp_problem_test`, `aha_mapper`, `scope_cutter`, `slc_or_mvp` (and
`pricing_tier_math` / `reverse_freemium_design` if pricing is in play), then synthesize
the 2×2 + strategy-fit yourself. If they're absent, run the inline rules in the
`references/` files — this skill is fully self-contained.

---

## About this skill

Part of the **[ProductMind Skills](https://github.com/ojiudezue/productmind-skills)**
catalog — open-source product-judgment skills for AI coding agents.

**Source:** *Building Rocketships* by Oji and Ezinne Udezue — Ch 1, 3, 4, 5, 7.
This skill composes several named frameworks into one feature gate. It works standalone
in any agent that supports the SKILL.md standard.

**Want the orchestrated version?** **Shipyard** (the RocketshipsGPT agent) runs all the
book skills together with persistent memory, framework-fidelity evals, and the book's
anti-pattern catches built in. → [skills.productmind.co](https://skills.productmind.co?utm_source=pms&utm_medium=skill-footer&utm_campaign=vet-a-feature)

**License:** Skill content under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Attribution required; derivatives share alike.
