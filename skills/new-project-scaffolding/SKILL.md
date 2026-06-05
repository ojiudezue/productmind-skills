---
name: project-scaffold
description: >
  Scaffolds any new software project with full product-layer AND code-layer infrastructure in one pass.
  Use this skill whenever the user says "scaffold a project", "new project", "start a project",
  "set up a new app", "spin up a project", "create a new repo", or any variation of initiating a
  fresh software build. Also trigger when the user mentions wanting a product brief, market research,
  CI/CD setup, testing infrastructure, or prototyping system as part of starting something new.
  This skill does NOT just create folder structures — it applies product-design-engineering practice
  as a co-equal part of scaffolding. If the user is starting something from scratch, use this skill.
---

# Project Scaffold System

Scaffolds a complete software project across two layers simultaneously:

- **Project layer**: product brief, market research, viability gate, quality tracking
- **Code layer**: repo structure, testing, CI/CD, documentation, prototyping

## Workflow

### Step 1: Gather Context (ask only what you can't infer)

Ask the user three things:

1. **Project type** — What are we building?
   - iOS app, Android app, web app (React/Next/etc.), API service, CLI tool, Python package, monorepo, etc.
   - If ambiguous, propose your best guess and let them correct it.

2. **Reference projects** — Which existing projects should we borrow patterns from?
   - This saves enormous time. Reuse folder conventions, CI configs, testing setups, CLAUDE.md patterns.
   - If the user has no references, proceed from the templates in `templates/`.

3. **Domain context** — What does this product do, who is it for, and what problem does it solve?
   - One or two sentences is enough. This feeds the product brief and viability check.

### Step 2: Run the Viability Gate

Before writing any code, generate a viability assessment. Read `references/viability-criteria.md` for the full rubric.

The viability assessment covers:

- Problem clarity and urgency
- Target user definition
- Competitive landscape (quick scan)
- Differentiation / unfair advantage
- Technical feasibility at current resources
- Revenue or impact path

**Kill criteria**: If 3+ of the 6 dimensions score "Weak," flag the project as high-risk and recommend the user either pivot the concept or consciously accept the risk before proceeding. Do not silently continue.

Write the assessment to `docs/viability-assessment.md`.

### Step 3: Generate the Product Brief

Create `docs/product-brief.md` with this structure:

```
# [Project Name] — Product Brief

## Problem
## Target User
## Value Proposition
## Success Criteria (measurable)
## Scope Boundaries (what this is NOT)
## Key Assumptions
## Open Questions
```

### Step 4: Conduct Market Research

Create `docs/market-research.md`. Read `references/market-research-template.md` for depth guidance.

This is not a placeholder — do real research:

- Direct competitors (3-5 minimum)
- Adjacent products that partially solve the problem
- Differentiation gaps and opportunities
- Pricing/business model patterns in the space
- User sentiment signals (app store reviews, forum complaints, Reddit threads)

Use web search to populate this. If web search is unavailable, clearly mark sections as "NEEDS RESEARCH" so the user knows to fill them.

### Step 5: Generate CLAUDE.md

Create a `CLAUDE.md` tailored to the project type. Read `references/claude-md-patterns.md` for type-specific templates.

Every CLAUDE.md must include:

- Project description and architecture overview
- Tech stack and key dependencies
- Code conventions (naming, file organization, import style)
- Testing expectations (what to test, how to run)
- PR/commit conventions
- Common pitfalls specific to this stack

### Step 6: Scaffold the Folder Structure

```
project-root/
├── CLAUDE.md
├── README.md
├── docs/
│   ├── product-brief.md
│   ├── market-research.md
│   ├── viability-assessment.md
│   ├── quality-log.md          # Bug classification tracker
│   └── milestones/             # README per milestone
│       └── m0-scaffold.md
├── prototypes/                 # HTML/CSS prototypes (UI projects only)
│   └── README.md
├── src/                        # Varies by project type
├── tests/                      # Mirrors src/ structure
├── .github/
│   └── workflows/
│       └── ci.yml
└── .gitignore
```

For the `quality-log.md`, initialize it with this structure:

```markdown
# Quality Log

## Bug Classification
| ID | Date | Severity | Category | Description | Root Cause | Resolution | Recurrence? |
|----|------|----------|----------|-------------|------------|------------|-------------|

## Categories
- Logic, UI/UX, Performance, Data, Security, Integration, Infrastructure

## Patterns
(Updated as bugs accumulate — look for recurring root causes)
```

### Step 7: Set Up Testing Infrastructure

Do not set up just one type of test. Read `references/testing-by-project-type.md` and set up what's appropriate:

| Project Type | Testing Layers |
|---|---|
| Web app | Unit (vitest/jest), component (testing-library), e2e (playwright), accessibility (axe) |
| iOS | Unit (XCTest), UI (XCUITest), snapshot |
| API | Unit, integration, contract, load |
| CLI | Unit, integration (bats/shellspec), snapshot |
| Python package | Unit (pytest), type checking (mypy), property-based (hypothesis) |

Create config files, sample test files, and npm/pip scripts so tests run immediately.

### Step 8: Set Up CI/CD

Generate `.github/workflows/ci.yml` (or equivalent) that:

- Runs all test types from Step 7
- Runs linting/formatting checks
- Runs type checking if applicable
- Fails fast on the cheapest checks first
- Includes a build/deploy step (even if it's just a placeholder)

Read `references/ci-templates.md` for project-type-specific pipelines.

### Step 9: Set Up Prototyping (UI Projects Only)

If the project has a user interface:

1. Create `prototypes/` with a README explaining the prototyping workflow
2. Set up a simple HTML/CSS prototype scaffold (no framework, pure markup)
3. The rule: **prototype in HTML/CSS first, then build in the target framework**
4. Prototypes are iterated and reviewed before production code begins

### Step 10: Fetch Skills

Check `references/skills-by-project-type.md` and recommend or fetch relevant skills across these categories:

| Category | Purpose |
|---|---|
| **Design** | UI design, interaction design, information architecture, accessibility |
| **Testing** | Unit, integration, e2e, performance — multiple, not just one |
| **Product** | Strategy, analytics instrumentation, user research, prioritization |
| **Platform** | iOS, Android, web, API, CLI — whatever the project needs |

List what skills are available and which ones you're applying. If a needed skill doesn't exist, note it as a gap.

### Step 11: Write the Milestone 0 Doc

Create `docs/milestones/m0-scaffold.md` documenting:

- What was set up and why
- Architecture decisions made
- Reference projects borrowed from
- What the next milestone should tackle

This is the first entry in the project's documentation trail. Every future milestone gets its own doc.

---

## Key Principles

- **Product-design-engineering are co-equal from day one.** Scaffolding is not just folder creation — it's establishing how the team thinks about the product.
- **Kill early.** The viability gate exists so bad ideas don't consume weeks of effort.
- **Multiple skills per category.** One testing framework is not enough. One design perspective is not enough.
- **Documentation is continuous.** Every milestone, every code critique, every bug gets recorded.
- **Borrow aggressively.** Reference projects exist so the system doesn't reinvent conventions every time.
