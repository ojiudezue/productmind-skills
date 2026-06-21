# ProductMind Skills — Product Brief

## Problem

AI coding assistants have made engineers dramatically more productive at writing code, but they've made it easier to build the *wrong thing faster*. The skills ecosystem (25,000+ skills and growing) is almost entirely engineering-focused — linting, testing, deployment, refactoring. Product thinking — understanding what to build, for whom, and why — is absent from the tools builders actually use every day.

## Target User

**Builders who ship software that matters** — founders, PMs, engineers, and vibe-coders from all walks. They use Claude Code (or compatible agents like Codex CLI, Cursor, Gemini CLI) as a daily driver and want business and product judgment embedded in their tools, not in a separate process. We assume some familiarity with the subject matter — these aren't dumbed down for total beginners (who aren't browsing GitHub anyway) — but you don't need to have read the book to use them.

Secondary audience: product- and business-minded teams who want to codify their practices into reusable, shareable skills.

## Value Proposition

ProductMind Skills is the only open-source skills collection that treats **business and product judgment** as a first-class engineering concern. The business-and-product side is the differentiator — every skill blends it with engineering rigor, from scaffolding projects with built-in viability gates, to vetting whether a feature is worth building, to embedding quality tracking into the development workflow.

## Success Criteria (measurable)

1. **GitHub stars**: 500+ within 6 months of launch (signals market resonance)
2. **Skill count**: 20+ production-quality skills at launch, growing to 50+ by month 6
3. **Community contributions**: 10+ external PRs within 6 months
4. **Adoption signal**: Skills referenced or forked by 5+ other repos
5. **Brand impact**: ProductMind mentioned in 3+ "best Claude skills" roundups

## Scope Boundaries (what this is NOT)

- NOT a skills marketplace platform (GitHub *is* the platform)
- NOT a Claude Code fork or extension
- NOT a general-purpose skills dump — every skill must embody the product-engineering blend
- NOT limited to Claude Code — skills follow the open SKILL.md standard and should work across compatible agents

## Key Assumptions

1. The SKILL.md open standard will remain stable and cross-agent compatible
2. GitHub remains the primary distribution channel for open-source skills
3. Builders want product thinking embedded in their tools, not as a separate process
4. Quality and curation will differentiate in an increasingly crowded skills space

## Open Questions

1. ~~Should skills be organized by workflow stage (discover → define → build → ship) or by category (product, design, engineering)?~~ **Answered (2026-06-03):** workflow stage. The Building Rocketships catalog uses discover → define → build → ship → lead, and it's the natural way PMs think about the lifecycle.
2. What's the right granularity — many small focused skills or fewer comprehensive ones?
3. How to handle skills that need web search or MCP servers — document requirements or bundle?
4. Community contribution guidelines — how strict on the product-engineering blend requirement?

## Roadmap — [Building Rocketships](https://shop.app/p/7480565334192) catalog (added 2026-06-03; updated 2026-06-21)

Book-derived skills are published to this catalog as each is built. They ship under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) for skill content — see [LICENSE](../LICENSE). The catalog is now **14 frameworks** plus the scaffolding and decision-trail tools.

### Discover — finding sharp problems

- [x] [`sharp-problem-test`](../skills/sharp-problem-test/) — Ch 1, the 3-Question Sharpness Test (≥3x improvement floor)
- [x] [`customer-discovery-week`](../skills/customer-discovery-week/) — Ch 1, the 3-step 1-week discovery process
- [x] [`five-dim-customer`](../skills/five-dim-customer/) — Ch 11, the 5-dimension target customer definition
- [x] [`listening-machine`](../skills/listening-machine/) — Ch 2, the customer feedback machine

### Define — choosing what to build

- [x] [`slc-or-mvp`](../skills/slc-or-mvp/) — Ch 3, the MVP vs SLC decision framework
- [x] [`aha-mapper`](../skills/aha-mapper/) — Ch 4, mapping the aha moment + smallest loop
- [x] [`scope-cutter`](../skills/scope-cutter/) — Ch 3/4, cutting required-onboarding-steps in half

### Build — monetization and identity choices

- [x] [`reverse-freemium-design`](../skills/reverse-freemium-design/) — Ch 5, the 4-element reverse-freemium template
- [x] [`pricing-tier-math`](../skills/pricing-tier-math/) — Ch 6, cost-floor → target-margin → market-anchor pricing
- [x] [`customer-id-architect`](../skills/customer-id-architect/) — Ch 4, GUIDs over emails as primary identifiers

### Ship — measurement and growth

- [x] [`vmsoop-strategy`](../skills/vmsoop-strategy/) — Ch 7+14, VMSOO-P plus cascading Tier 1/Tier 2 metrics
- [x] [`growth-lever-picker`](../skills/growth-lever-picker/) — Ch 12, the 10 growth levers scored by ICE
- [x] [`roadmap-from-strategy`](../skills/roadmap-from-strategy/) — Ch 14+Epilogue, roadmap as ordered sharp-problem queue

### Compose — vetting decisions across the lifecycle

- [x] [`vet-a-feature`](../skills/vet-a-feature/) — Ch 1–7, the brownfield feature gate. Composes sharpness (≥3x), the sharpness×ease prioritization grid, strategy fit, activation ("aha") fit, and SLC/scope into a single BUILD / BUILD_SMALLER / PARK / SCRAP verdict. The catalog's first orchestrator skill — it does one job (decide whether a feature is worth building) by drawing on several frameworks at once.

New skills land as they're authored; this catalog is the source of truth for what's shipped.
