# ProductMind Skills

**Business and product judgment meets engineering rigor.** An open-source collection of AI-agent skills for the people who ship software that matters — founders, PMs, engineers, and vibe-coders alike.

Most skills repos help you write code faster. ProductMind Skills help you **build the right thing**. The business and product judgment is the part no other skills collection gives you — that's the differentiator.

## Recent updates

- **2026-08** — `auto-kanban`: cards gain `created`/`updated` timestamps, a `refinement_status`
  (initial vs refined), and a **mandatory plain-language `problem_solution`** — written for a
  reader who wasn't in the room, jargon kept out of the framing. Renderer surfaces all four.
- **2026-08** — `auto-kanban`: producer-AND-consumer discipline (a consumer-only rule set is a
  structural blind spot) plus the discriminating-acceptance-criteria corollary, both earned from
  a real double-count defect.
- **2026-08** — `auto-kanban` grew a full operator-disposition loop: `approve`/`investigate`
  buttons on intake cards, a force-gated queue-apply (distinct `--check` exit code — a chip is
  a banner, the exit code is the mechanism), and a bounded lull-investigation doctrine with a
  six-verdict vocabulary for intake triage. Plus production field notes (test isolation from
  the live queue; end-to-end button→API verification).
- **2026-08** — `auto-kanban` hosted-board pattern hardened: ship-gate `--cards` flag,
  staleness contract, cron pull-and-render hosting, example schema + self-contained demo board.
- **2026-07** — repo hygiene: markdownlint CI + auto-fixes across skills.

## What's Different

Every skill blends business and product judgment with engineering execution:

- **Scaffold a project** → starts with a viability gate and product brief, not just folder creation
- **Vet a feature** → decides whether it's even worth building (and the smallest version that is) before you write code, not just how to build it
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

> 📖 The book-derived skills below apply named frameworks from **[Building Rocketships][book]** by Oji & Ezinne Udezue. **You don't need to have read the book** — each skill defines its terms and thresholds as it runs. The Category column shows the product-lifecycle stage and source chapter; grab the book to go deeper.

| Skill | Category | Description |
|---|---|---|
| [new-project-scaffolding](skills/new-project-scaffolding/) | Product + Engineering | Scaffolds projects with viability gates, product briefs, market research, and full code infrastructure |
| [vet-a-feature](skills/vet-a-feature/) | Product Decision ([Building Rocketships][book], Ch 1–7) | Decides whether to build a proposed feature on a product you already ship. Composes the sharpness ≥3x test, a sharpness×ease prioritization grid, strategy fit, activation ("aha") fit, and smallest-version scoping into one verdict — BUILD / BUILD_SMALLER / PARK / SCRAP / NEEDS_MORE_INPUT — with confidence per dimension that degrades gracefully when you only have partial inputs. Refuses the book's feature anti-patterns (e.g. paywalling the core workflow). The catalog's first *orchestrator*: one job, many frameworks |
| [auto-kanban](skills/auto-kanban/) | Product + Engineering | Capture-first kanban board for agent workflows — every user push and agent mid-turn discovery becomes a card the same turn, before acting. YAML source of truth, rendered markdown/HTML views with a staleness banner, and a release-script ship gate that marks cards shipped as part of the deploy flow. Pairs with vibememo: that captures the WHY, this captures WHAT / WHERE / NEXT |
| [vibememo](skills/vibememo/) | Product + Engineering | Decision trail capture system — persists the "why" behind architectural, product, and strategic decisions as structured JSON + compressed narrative |
| [sharp-problem-test](skills/sharp-problem-test/) | Product Discovery ([Building Rocketships][book], Ch 1) | Runs the 3-Question Sharpness Test on a product brief. Returns SHARP / NOT_SHARP / NEEDS_MORE_EVIDENCE with evidence per axis, the ≥3x improvement-bar check, and a named analogous case from the book |
| [reverse-freemium-design](skills/reverse-freemium-design/) | Product Build ([Building Rocketships][book], Ch 5) | Runs the 4-Element Reverse Freemium Design framework. Returns trial length tied to the usage-frequency table, free vs paid feature segmentation, end-of-trial messaging plan, post-trial retention, and the paywalled-final-step anti-pattern check |
| [pricing-tier-math](skills/pricing-tier-math/) | Product Build ([Building Rocketships][book], Ch 6) | Runs the Cost-Margin-Tier Pricing framework. Takes a bottom-up cost basis and market anchors, returns the cost-derived base price, 3+ tier structure with feature assignment per the 3-factor rule, and add-ons for niche features |
| [slc-or-mvp](skills/slc-or-mvp/) | Product Define ([Building Rocketships][book], Ch 3) | Runs the SLC-vs-MVP decision framework (Simple-Lovable-Complete vs Minimum-Viable-Product). Returns MVP / SLC / NEEDS_MORE_EVIDENCE with reasoning, scope cuts, acceptance criteria, and a refusal mode for the "MVP-shipped-as-product" anti-pattern |
| [aha-mapper](skills/aha-mapper/) | Product Define ([Building Rocketships][book], Ch 4) | Runs the Aha-Moment Smallest Loop framework. Identifies the loop completed by the 80-90th percentile of activated customers. Returns the aha ("the moment a user first gets the value") statement, loop spec, cognitive-orientation script, activation acceptance criteria, and a free-tier-completes-loop check |
| [scope-cutter](skills/scope-cutter/) | Product Define ([Building Rocketships][book], Ch 3/4) | Runs the Required-vs-Helpful scope cut framework targeting the "halve the required onboarding list" rule. Returns a two-column allocation, the progressive-disclosure nudge sequence, and an activation-impact estimate using the 5-15%-per-step heuristic |
| [customer-discovery-week](skills/customer-discovery-week/) | Product Discovery ([Building Rocketships][book], Ch 1) | Runs the 3-Step 1-Week Continuous Discovery process. Returns a discovery plan: target cohort, motivation + workflow interview scripts, survey draft, synthesis template, and a day-by-day time budget. Refuses survey-only plans |
| [five-dim-customer](skills/five-dim-customer/) | Product Discovery ([Building Rocketships][book], Ch 11) | Runs the 5-Dimension Target Customer framework. Returns a dossier across Role, Persona, Objectives, Sharp Problems, jobs-to-be-done (JTBD) + workflow (with preceding + succeeding workflows). Refuses to fabricate customer data |
| [listening-machine](skills/listening-machine/) | Product Discovery ([Building Rocketships][book], Ch 2) | Runs the Customer Listening Machine framework. Returns a wiring diagram for the 4 required channels, a triage SLA, a first-month rollout plan, and the cross-channel ≥2 signal rule |
| [vmsoop-strategy](skills/vmsoop-strategy/) | Product Ship ([Building Rocketships][book], Ch 7 + 14) | Runs VMSOO-P (the book's Vision / Mission / Strategies / Opportunity-costs / Objectives / Priorities planner) + cascading Tier 1/Tier 2 metrics. Returns Vision, Mission/North Star (with 5-criteria check), Strategies, Opportunity Costs, Objectives, Priorities, plus tiered metrics. Refuses mature North Star design pre-product-market-fit (PMF) |
| [growth-lever-picker](skills/growth-lever-picker/) | Product Ship ([Building Rocketships][book], Ch 12) | Runs the 10-Lever Growth Framework + book-variant ICE scoring (Impact*2 - Cost - Effort). Returns a ranked shortlist, 70/20/10 portfolio split, opportunity costs, and sequencing |
| [roadmap-from-strategy](skills/roadmap-from-strategy/) | Product Ship ([Building Rocketships][book], Ch 14 + Epilogue) | Runs the Problem-Ordered Roadmap framework. Returns a roadmap ordered by sharp-problem priority (not effort), each item carrying its problem + customer story + strategy lever + success metric. Enforces an 80/20 split of new-build vs keep-the-lights-on (KTLO) work, with a hard halt past 40% KTLO |
| [customer-id-architect](skills/customer-id-architect/) | Product Build ([Building Rocketships][book], Ch 4) | Runs the Identity-with-GUIDs framework. Audits the current primary-key design and refuses email-as-PK outright. Returns the proposed schema, migration sequence, and the compounding-pain timeline if no fix |

*The Building Rocketships catalog is now 14 frameworks (plus the scaffolding and decision-trail tools above) and still growing. See [docs/product-brief.md](docs/product-brief.md) for the roadmap. Want them orchestrated together — with memory, framework-fidelity evals, and the book's anti-pattern catches built in? That's the hosted agent at [skills.productmind.co](https://skills.productmind.co).*

## Skill Quality Standards

Every skill in this collection must:

1. **Blend product and engineering** — pure engineering skills belong elsewhere
2. **Encode judgment, not just instructions** — skills should help you *think*, not just automate
3. **Follow the SKILL.md standard** — portable across Claude Code, Codex CLI, Cursor, Gemini CLI, and more
4. **Be self-contained** — include all references and context needed
5. **Pass structural validation** — clear `validate-skills.sh` (structure, frontmatter, links) before merging. (Framework-fidelity evals for the book skills are run upstream where the frameworks are authored — they don't live in this repo.)

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

This repo is **split-licensed by artifact type**:

- **Skill content** — every `SKILL.md` and the docs prose: **[CC BY-SA 4.0](LICENSES/CC-BY-SA-4.0.txt)**. Attribution required; derivative works must share alike, and each skill's footer (attribution + link) must stay intact when you redistribute.
- **Tooling** — `scripts/`, `tests/`, validators: **[MIT](LICENSES/MIT.txt)**.

The split keeps the framework content open and attributed while leaving the tooling permissively licensed. See [`LICENSE`](LICENSE) for the full terms.

[book]: https://shop.app/p/7480565334192
