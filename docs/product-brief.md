# ProductMind Skills — Product Brief

## Problem

AI coding assistants have made engineers dramatically more productive at writing code, but they've made it easier to build the *wrong thing faster*. The skills ecosystem (25,000+ skills and growing) is almost entirely engineering-focused — linting, testing, deployment, refactoring. Product thinking — understanding what to build, for whom, and why — is absent from the tools builders actually use every day.

## Target User

**Multi-skilled builders**: Engineers who care about product outcomes, not just code quality. They use Claude Code (or compatible agents like Codex CLI, Cursor, Gemini CLI) as their daily driver. They want skills that help them think clearly about product decisions *while* they build, not in a separate tool or process.

Secondary audience: Product-minded engineering teams who want to codify their product practices into reusable, shareable skills.

## Value Proposition

ProductMind Skills is the only open-source skills collection that treats product thinking as a first-class engineering concern. Every skill blends product judgment with engineering rigor — from scaffolding projects with built-in viability gates, to running market research alongside code generation, to embedding quality tracking into the development workflow.

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

1. Should skills be organized by workflow stage (discover → define → build → ship) or by category (product, design, engineering)?
2. What's the right granularity — many small focused skills or fewer comprehensive ones?
3. How to handle skills that need web search or MCP servers — document requirements or bundle?
4. Community contribution guidelines — how strict on the product-engineering blend requirement?
