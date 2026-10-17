# Feature Decision Record (FDR) — template

The durable artifact. Always generated (BUILD, BUILD_SMALLER, PARK, and SCRAP). It's an
ADR for a feature: it records the call **and the reasoning**, so a future reader knows
why — and under what condition to reconsider.

```markdown
# FDR-NNN — [Feature name]

**Verdict:** BUILD | BUILD_SMALLER | PARK | SCRAP
**Confidence:** high | medium | low   **Date:** YYYY-MM-DD

## Decision
One sentence: build / build smaller / park / scrap, and the headline why.

## Evidence
- **Sharpness:** SHARP/NOT_SHARP + the ≥3x read.
- **2×2 placement:** build-now / build-alongside / long-term-moat / scrap (+ axes).
- **Strategy fit:** the line of sight, or "no apparent linkage".
- **Aha fit:** advances / orthogonal.
- **Anti-patterns tripped:** list, or none.

## Smallest version (if building)
SLC vs MVP + the smallest activating loop.

## Confidence & gaps
Overall confidence and the missing inputs that would raise it.

## Revisit trigger
The specific condition under which this decision should be reconsidered
(e.g. "if the adjacent sharp feature ships", "if a peer feature is descoped",
"if usage frequency turns out to be daily, not monthly").
```

## Why the revisit trigger matters

PARK and SCRAP are not permanent. The trigger is what turns "no, not now" into a
re-evaluation later — without it, parked features are silently lost or re-litigated from
scratch.
