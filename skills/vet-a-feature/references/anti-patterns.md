# Anti-patterns — refuse outright (don't soften)

If a feature trips one of these, flag it with chapter + action. A **refuse**-level trip
caps the verdict at **SCRAP** (or **PARK** if the feature is salvageable by removing the
anti-pattern). A **warn**-level trip is noted but doesn't cap the verdict.

| Anti-pattern | Action | Source | Why |
|---|---|---|---|
| **Paywalling the final step of the core workflow** | refuse | Ch 5, p86 | "Your free tier needs to allow customers to complete the full, core workflow." Paywalling the last step (e.g. an ugly watermark) just drives customers to a competitor. |
| **Email / PII as the primary customer ID** | refuse | Ch 7, p114 | Use an anonymized GUID, not PII. Email-as-PK creates identity debt (users can't change it without losing history). |
| **Mature North Star / strict metrics on a pre-PMF feature** | warn | Ch 7, p122 | New incubations "should initially have a less-strict metrics regime than mature product lines." A firm North Star implies you already have PMF. |
| **Sales-trial gating in a product-led-growth motion** | warn | Ch 5, p78 | "The antithesis of product-led growth — least generous, least psychologically safe, highest-friction." |

## How to apply

- Name the tripped pattern, its chapter, and `refuse` vs `warn`.
- For a `refuse`: can the feature survive if the anti-pattern is removed? If yes → PARK
  with the fix as the revisit trigger. If the anti-pattern *is* the feature → SCRAP.
- Never quote the verdict softer than the rule. The anti-pattern catch is the point.
