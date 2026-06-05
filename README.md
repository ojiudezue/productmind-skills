# ProductMind Skills

**Product thinking meets engineering rigor.** An open-source collection of AI coding agent skills for builders who ship important software.

Most skills repos help you write code faster. ProductMind Skills help you **build the right thing**.

## What's Different

Every skill in this collection blends product judgment with engineering execution:

- **Scaffold a project** → starts with a viability gate and product brief, not just folder creation
- **Plan a feature** → considers user impact, scope boundaries, and success criteria alongside the technical design
- **Review code** → evaluates product implications, not just code quality
- **Ship a release** → tracks quality patterns, not just test results

## Quick Start

### Install a single skill

```bash
# From your project directory
claude install-skill https://github.com/ojiudezue/productmind-skills/tree/main/skills/new-project-scaffolding
```

### Browse and install from the collection

```bash
# Clone the repo and symlink skills you want
git clone https://github.com/ojiudezue/productmind-skills.git
cd productmind-skills

# Copy a skill into your project
cp -r skills/new-project-scaffolding /path/to/your/project/.claude/skills/
```

## Skills Catalog

| Skill | Category | Description |
|---|---|---|
| [new-project-scaffolding](skills/new-project-scaffolding/) | Product + Engineering | Scaffolds projects with viability gates, product briefs, market research, and full code infrastructure |
| [vibememo](skills/vibememo/) | Product + Engineering | Decision trail capture system — persists the "why" behind architectural, product, and strategic decisions as structured JSON + compressed narrative |
| [sharp-problem-test](skills/sharp-problem-test/) | Product Discovery (Building Rocketships, Ch 1) | Runs the 3-Question Sharpness Test on a product brief. Returns SHARP / NOT_SHARP / NEEDS_MORE_EVIDENCE with evidence per axis, the ≥3x improvement-bar check, and a named analogous case from the book |
| [reverse-freemium-design](skills/reverse-freemium-design/) | Product Build (Building Rocketships, Ch 5) | Runs the 4-Element Reverse Freemium Design framework. Returns trial length tied to the usage-frequency table, free vs paid feature segmentation, end-of-trial messaging plan, post-trial retention, and the paywalled-final-step anti-pattern check |
| [pricing-tier-math](skills/pricing-tier-math/) | Product Build (Building Rocketships, Ch 6) | Runs the Cost-Margin-Tier Pricing framework. Takes a bottom-up cost basis and market anchors, returns the cost-derived base price, 3+ tier structure with feature assignment per the 3-factor rule, and add-ons for niche features |
| [slc-or-mvp](skills/slc-or-mvp/) | Product Define (Building Rocketships, Ch 3) | Runs the SLC-vs-MVP decision framework. Returns MVP / SLC / NEEDS_MORE_EVIDENCE with reasoning, scope cuts, acceptance criteria, and a refusal mode for the "MVP-shipped-as-product" anti-pattern |
| [aha-mapper](skills/aha-mapper/) | Product Define (Building Rocketships, Ch 4) | Runs the Aha-Moment Smallest Loop framework. Identifies the loop completed by the 80-90th percentile of activated customers. Returns the aha statement, loop spec, cognitive-orientation script, activation acceptance criteria, and a free-tier-completes-loop check |
| [scope-cutter](skills/scope-cutter/) | Product Define (Building Rocketships, Ch 3/4) | Runs the Required-vs-Helpful scope cut framework targeting the "halve the required onboarding list" rule. Returns a two-column allocation, the progressive-disclosure nudge sequence, and an activation-impact estimate using the 5-15%-per-step heuristic |

*More book-derived skills landing in waves. The full 13-skill catalog from Building Rocketships is mirrored from the [RocketshipsGPT agent](https://github.com/ojiudezue/BuildingRocketships) as each agent-side implementation lands. See [docs/product-brief.md](docs/product-brief.md) for the roadmap.*

## Skill Quality Standards

Every skill in this collection must:

1. **Blend product and engineering** — pure engineering skills belong elsewhere
2. **Encode judgment, not just instructions** — skills should help you *think*, not just automate
3. **Follow the SKILL.md standard** — portable across Claude Code, Codex CLI, Cursor, Gemini CLI, and more
4. **Be self-contained** — include all references and context needed
5. **Be tested** — pass automated validation before merging

## Contributing

We welcome contributions that fit the ProductMind philosophy. Before submitting:

1. Read the [product brief](docs/product-brief.md) to understand the vision
2. Ensure your skill blends product thinking with engineering
3. Follow the structure in `skills/example/` as a template
4. Run `./scripts/validate-skills.sh` to check your skill
5. Submit a PR with the skill, a test, and a catalog entry

## About ProductMind

ProductMind is about building software that matters — combining product strategy, design thinking, and engineering excellence. These skills encode that philosophy into the tools builders use every day.

## License

MIT
