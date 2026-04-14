# ProductMind Skills — Market Research

**Research depth**: Standard
**Date**: 2026-04-13

## 1. Market Overview

The AI coding assistant skills ecosystem has exploded in 2025-2026. Anthropic's release of the open SKILL.md standard created a portable format that works across Claude Code, Codex CLI, Cursor, Gemini CLI, GitHub Copilot, and other agents. SkillsMP now hosts 25,000+ skills, and GitHub is the primary distribution channel for open-source skill collections.

The market is supply-driven — most skills are created by individual developers sharing their workflows. Curation and quality vary wildly. The dominant pattern is engineering-focused: CI/CD automation, testing, code review, refactoring, deployment. Product and design skills exist but are rare, scattered, and not integrated into the engineering workflow.

Enterprise adoption is growing. Best practice is emerging around private GitHub repos as company-internal skills marketplaces, with auto-updating when skills are modified. This validates the GitHub-as-distribution model that ProductMind will use.

## 2. Direct Competitors

| Field | alirezarezvani/claude-skills | daymade/claude-code-skills | levnikolaevich/claude-code-skills | Anthropic/skills | SkillsMP |
|---|---|---|---|---|---|
| What they do | Largest community skills collection | Curated production-ready skills | Agile lifecycle plugin suite | Official Anthropic skills | Skills marketplace platform |
| Scale | 232+ skills, 5,200+ stars | 48 skills | Full lifecycle suite | Official collection | 25,000+ skills |
| Pricing | Free / open source | Free / open source | Free / open source | Free / open source | Free to browse, premium tiers |
| Strengths | Breadth, multi-agent support, community size | Quality curation, production-ready focus | Comprehensive Agile workflow, bundled MCP servers | Official backing, guaranteed compatibility | Scale, discoverability, cross-platform |
| Weaknesses | Quantity over quality, no product focus | Engineering-only, smaller scope | Complex setup, engineering-only | Limited scope, slow updates | Overwhelming, no quality signal, no product focus |
| User sentiment | Popular but "hit or miss quality" | "Actually useful, well-tested" | "Powerful but steep learning curve" | "Good starting point" | "Hard to find what you need" |

## 3. Adjacent Products

- **Product Compass PM Skills Marketplace**: Focuses on PM skills specifically but for general AI, not integrated into coding agents. Shows there's demand for product skills in AI tools.
- **Trust Insights "Prompts to Skills"**: Framework for converting prompts into reusable AI skills. Conceptual alignment with ProductMind but no coding agent integration.
- **Team-internal skills repos**: Many companies maintain private skills repos. These are the real competition for daily use — ProductMind needs to be good enough that teams adopt public skills alongside their private ones.

## 4. Differentiation Map

```
                    Engineering Focus
                         ↑
                         |
    alirezarezvani •     |     • daymade
                         |
    levnikolaevich •     |     • Anthropic/skills
                         |
    ─────────────────────┼──────────────────→ Product Focus
    Broad                |              Focused
                         |
                         |     ★ ProductMind Skills
                         |       (target position)
                         |
                         |     • Product Compass
```

**The whitespace**: No one occupies the intersection of product thinking + engineering rigor + Claude Code skills. ProductMind targets this gap directly.

## 5. Pricing & Business Model Patterns

- **Dominant model**: Free / open source on GitHub (community collections)
- **Emerging model**: Freemium marketplaces (SkillsMP — free browse, premium for bundled/tested skills)
- **Enterprise model**: Private repos with curated skills (companies pay for curation, not the skills themselves)
- **ProductMind model**: Free / open source. Monetization is indirect — reputation, brand equity, consulting leads, speaking opportunities, community leadership.

## 6. User Signals

- **GitHub discussions**: Developers consistently ask "which skills are actually worth installing?" — quality signal is the #1 unmet need
- **Medium/blog roundups**: "Best Claude skills" articles get high engagement, indicating demand for curation
- **Reddit threads**: Common complaints: "most skills are just wrappers around basic prompts," "I want skills that actually change how I work, not just automate what I already do"
- **Enterprise feedback**: Teams want skills that enforce process and standards, not just speed up coding

## Key Takeaway

The market validates demand. The gap is clear: product-aware skills that change how builders think, not just how fast they type. ProductMind's positioning is strong if execution matches the ambition.
