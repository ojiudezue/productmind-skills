# Milestone 0: Project Scaffold

**Date**: 2026-04-13

## What Was Set Up

### Product Layer
- **Viability assessment** (`docs/viability-assessment.md`): 0 Weak scores — strong positioning in a validated market with a clear differentiation gap
- **Product brief** (`docs/product-brief.md`): Problem, target user, value prop, success criteria, scope boundaries
- **Market research** (`docs/market-research.md`): 5 direct competitors analyzed, differentiation map, pricing patterns, user signals
- **Quality log** (`docs/quality-log.md`): Bug classification tracker initialized

### Code Layer
- **CLAUDE.md**: Full project context — structure, conventions, testing, quality standards, common pitfalls
- **README.md**: GitHub shop front — value prop, quick start, skills catalog, quality standards, contributing guide
- **Skills directory** (`skills/`): Published skills with `new-project-scaffolding` as the first entry, plus `example/` as a template
- **Validation tooling** (`scripts/`): `validate-skills.sh` (structure + naming + product-blend checks), `check-links.sh`, `ci-local.sh`
- **Testing** (`tests/`): Integration tests for the validation script
- **CI/CD** (`.github/workflows/ci.yml`): Markdown linting, skill validation, link checking
- **Prototypes** (`prototypes/`): Directory with workflow documentation, ready for any future UI work

## Architecture Decisions

1. **GitHub as the shop front**: No separate website or marketplace platform. The README *is* the product page. This keeps overhead at zero and plays to GitHub's strengths as a discovery platform.
2. **Skills as first-class directories**: Each skill gets its own directory with SKILL.md + optional references. This is the portable, cross-agent standard.
3. **Validation over convention docs**: Instead of writing lengthy contributor guidelines, the validation script *enforces* standards — kebab-case naming, required sections, minimum content, product-thinking signals.
4. **Shell-based tooling**: No Node/Python dependencies for core tooling. Scripts run anywhere with bash. Markdown linting uses npx (optional) for CI.

## Reference Projects Borrowed From

None — this is a new project type. Patterns were derived from:
- The SKILL.md open standard (Anthropic)
- Competitor analysis of alirezarezvani/claude-skills, daymade/claude-code-skills, levnikolaevich/claude-code-skills
- SkillsMP marketplace conventions

## Skills Applied

| Category | Skill | Status |
|---|---|---|
| Product | Product strategy (viability + brief) | Applied |
| Product | Market research | Applied |
| Testing | Skill validation (custom) | Applied |
| Testing | Markdown linting | Applied |
| Testing | Link checking | Applied |
| Design | GitHub README as shop front | Applied |
| Platform | SKILL.md standard compliance | Applied |

### Skill Gaps (not yet available)

- Analytics instrumentation (track skill adoption/usage)
- Community management (issue templates, PR templates, contributor onboarding)
- SEO/discoverability (GitHub topics, description optimization)

## What Milestone 1 Should Tackle

1. **Publish 5+ more skills** that demonstrate the product-engineering blend across different workflows
2. **GitHub repo setup**: Initialize git, create the GitHub repo, push, configure topics/description for discoverability
3. **Community infrastructure**: Issue templates, PR templates, CONTRIBUTING.md, CODE_OF_CONDUCT.md
4. **Skill categories**: Decide on organization — by workflow stage (discover/define/build/ship) vs. by category
5. **Landing page**: Consider a simple GitHub Pages site or enhanced README with visual catalog
