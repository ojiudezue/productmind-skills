# ProductMind Skills

## Overview

An open-source collection of Claude Code skills that blend product thinking with engineering rigor. Built for multi-skilled builders who want to ship important software, not just write code. Skills follow the open SKILL.md standard and work across Claude Code, Codex CLI, Cursor, Gemini CLI, and other compatible agents.

## Tech Stack

- Language: Markdown (skills), Shell/Node (tooling)
- Format: SKILL.md open standard
- Distribution: GitHub (primary), compatible with SkillsMP
- CI: GitHub Actions
- Validation: Custom shell scripts + markdownlint

## Project Structure

```
productmind-skills/
├── CLAUDE.md              # This file — project context for AI agents
├── README.md              # GitHub shop front — the public face
├── skills/                # All published skills, one directory per skill
│   └── <skill-name>/
│       ├── SKILL.md       # The skill definition (required)
│       └── references/    # Supporting files the skill references (optional)
├── docs/                  # Product and project documentation
│   ├── product-brief.md
│   ├── market-research.md
│   ├── viability-assessment.md
│   ├── quality-log.md
│   └── milestones/
├── tests/                 # Skill validation tests
├── scripts/               # Tooling for validation, linting, setup
├── prototypes/            # HTML/CSS prototypes for any UI work
└── .github/workflows/     # CI/CD pipelines
```

## Code Conventions

- **Skill naming**: lowercase-kebab-case directories (e.g., `skills/new-project-scaffolding/`)
- **File naming**: SKILL.md (uppercase) for skill definitions, lowercase-kebab-case for everything else
- **Markdown style**: ATX headings (`#`), fenced code blocks with language tags, tables for structured data
- **Skill structure**: Every SKILL.md must have a clear title, description, trigger conditions, and step-by-step instructions
- **References**: Supporting files go in a `references/` subdirectory within the skill folder

## Testing

- Validate all skills: `./scripts/validate-skills.sh`
- Lint markdown: `npx markdownlint-cli2 "**/*.md"`
- Check links: `./scripts/check-links.sh`
- Run full CI locally: `./scripts/ci-local.sh`

## Quality Standards

Every skill in this collection must:
1. **Blend product and engineering** — pure engineering skills belong elsewhere
2. **Be self-contained** — include all references and context needed to execute
3. **Follow SKILL.md standard** — portable across compatible agents
4. **Include trigger conditions** — clearly state when the skill should activate
5. **Be tested** — pass validation before merging

## PR/Commit Conventions

- Commit messages: `add: <skill-name>`, `update: <skill-name>`, `fix: <description>`, `docs: <description>`, `infra: <description>`
- PRs for new skills must include: the skill, a test, and an entry in README.md's skill catalog
- One skill per PR unless they're tightly coupled

## Common Pitfalls

1. Writing skills that are just prompt wrappers — every skill should encode *judgment*, not just instructions
2. Forgetting trigger conditions — without clear triggers, skills never activate
3. Making skills too broad — focused skills that do one thing well beat Swiss-army-knife skills
4. Skipping the product angle — if a skill doesn't blend product thinking, it doesn't belong here
5. Hardcoding paths or tool-specific syntax — skills should be portable across agents
