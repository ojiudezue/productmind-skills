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

*More book-derived skills landing in waves — the next batch is `reverse-freemium-design` and `pricing-tier-math`. The full 13-skill catalog from Building Rocketships is mirrored from the [RocketshipsGPT agent](https://github.com/ojiudezue/BuildingRocketships) as each agent-side implementation lands. See [docs/product-brief.md](docs/product-brief.md) for the roadmap.*

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
