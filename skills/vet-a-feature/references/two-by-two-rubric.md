# Sharpness × ease-of-solving 2×2 (Ch 1, p15)

The book's feature-prioritization method. Place the feature on two axes.

- **Sharpness axis** (from `sharp-problem-3x.md`): high / low.
- **Ease axis**: easy / hard. **Ease includes go-to-market, not just engineering** —
  a feature that's trivial to build but needs a new sales motion is *hard*.

|                | **Easy to solve**        | **Hard to solve**          |
|----------------|--------------------------|----------------------------|
| **High sharpness** | **build-now**          | **long-term-moat** (not now, don't ignore) |
| **Low sharpness**  | **build-alongside** (only riding a sharper feature) | **scrap**                  |

## Reading it

- **build-now** — the default green light.
- **long-term-moat** — real value, high cost. Sequence it later; it's defensible.
- **build-alongside** — only justified if it ships *with* a sharper feature it enables.
- **scrap** — low value, high cost. Say no.

## When you lack an effort signal

No codebase, no estimate? Infer ease from **go-to-market difficulty** (new motion? new
buyer? support load?) and stamp the ease axis **LOW confidence**. The 2×2 is also
**comparative** — its placement is sharpest when you can rank the feature against the
other features in flight. Without peers, lower `two_by_two` confidence.

> Roadmap (Ch 1): a roadmap is "a sequential list of your sharpest problems." Track the
> attempt-solve rate. "Ease" is the tiebreaker, not the driver — sharpness leads.
