# Confidence model — graceful degradation

People bring what they have. Never block on missing inputs beyond the Tier-1 gate;
instead, **lower the confidence of the specific dimension** the missing input feeds, and
tell the user what it cost.

## Input tiers
- **Tier 1 (gate, required):** feature · problem · rough target customer.
  Missing any ⇒ `NEEDS_MORE_INPUT`.
- **Tier 2 (recommended):** product strategy / North Star · current aha/activation loop ·
  other features in flight or shipped.
- **Tier 3 (optional):** effort/codebase signal · pricing context · current metrics ·
  is-this-a-new-market.

## What each missing input degrades
| Missing | Effect |
|---|---|
| product strategy / North Star | `strategy_fit.ladders_to_strategy = unknown` |
| other features | `two_by_two` LOW (the 2×2 is comparative) |
| effort / codebase | `two_by_two.ease_axis` LOW (fall back to GTM difficulty) |
| activation loop | `aha_fit.relation = unknown` |
| current metrics / is-new-market | `success_metric` softer; default to pre-PMF leniency |

## Overall confidence
`confidence` = the **floor of the load-bearing dimensions** for the verdict. A SCRAP on a
trivial-workaround feature can be HIGH confidence with almost no Tier-2 input (sharpness
alone settles it). A BUILD usually needs strategy + ease signal to reach HIGH.

## Always
- Populate `missing_inputs` with what would raise confidence, most-valuable first.
- Prefer a **low-confidence real verdict** over `NEEDS_MORE_INPUT`.
- If the user explicitly can't provide more, give the call at its current confidence and
  say so — don't stall.
