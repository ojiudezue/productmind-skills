---
name: vibememo
description: >
  The decision trail capture system for software projects. Persists load-bearing architectural,
  product, and strategic decisions to `.vibememo/` as structured JSON entries and maintains a
  compressed human-readable narrative (`vibememo.md`). Invoke with /vibememo to capture a decision,
  or let it activate automatically when significant decisions are made in conversation. Pairs with
  the vibememo-eval companion skill for periodic quality checks.
---

# VibeMemo — Decision Trail Capture

VibeMemo is the flight data recorder for software development. It captures **why** your codebase is built the way it is — not just what was built, but the reasoning, tradeoffs, and pivots behind every load-bearing decision.

Architecture can be read from code. The reasoning behind decisions cannot. VibeMemo preserves the reasoning.

## Why This Is a Product Skill

Most decision-logging tools are engineering-only — they capture stack choices and architecture patterns. VibeMemo captures the full spectrum: product decisions, pricing tradeoffs, UX pivots, security concerns, and strategic bets alongside the technical choices. It treats product judgment as a first-class part of the decision trail, because in practice, the most important decisions are never purely technical.

## Setup

### 1. Initialize the `.vibememo/` directory

```bash
mkdir -p .vibememo/users/{your-git-username}/entries
```

### 2. Create project settings

Create `.vibememo/settings.json`:

```json
{
  "format_version": "2.0",
  "project_name": "Your Project",
  "verbosity": "standard",
  "narrative_target_words": 1200,
  "narrative_hard_ceiling": 2000,
  "narrative_version_threshold": 1500,
  "narrative_min_useful": 200,
  "auto_narrative_on_commit": true,
  "auto_narrative_loop_minutes": null,
  "narrative_generation": "llm",
  "heuristic_fallback": true,
  "categories": [
    "architecture", "stack", "brand", "product",
    "security", "deployment", "data_model", "ux",
    "pricing", "process"
  ]
}
```

### 3. Create the user index

Create `.vibememo/users/{your-git-username}/index.json`:

```json
{
  "author": "{your-git-username}",
  "project": "Your Project",
  "last_narrative_update": null,
  "entries": []
}
```

### 4. Create initial narratives

Create `.vibememo/vibememo.md` (project narrative) and `.vibememo/users/{your-git-username}/vibememo.md` (user narrative) with a placeholder heading.

### 5. Install hooks (recommended)

See [references/hooks.md](references/hooks.md) for pre-commit and session-end hook configurations that enforce narrative consistency.

### 6. Install the eval companion (recommended)

Copy [references/vibememo-eval.md](references/vibememo-eval.md) alongside this skill. Set up a 30-minute loop: `/loop 30m /vibememo-eval`

## When to Activate

Trigger a VibeMemo entry when:

1. **A load-bearing technical decision is made** — stack choice, data model, architecture pattern, deployment strategy
2. **A previous decision is reversed** — pivot. These are the most important entries.
3. **A critical security or scalability concern surfaces** — counseling
4. **A significant milestone is reached** — first working prototype, first deploy, first user
5. **The user explicitly asks** — `/vibememo` or "remember this" or "log this"

Do NOT create entries for:
- Routine code changes with no architectural significance
- Minor bug fixes or formatting changes
- Questions that don't result in decisions

## How to Write an Entry

1. **Read the current index**: `.vibememo/users/{username}/index.json` to get the next entry number
2. **Determine entry type and weight**:
   - Types: `decision` | `observation` | `counseling` | `milestone` | `pivot`
   - Weights: `critical` | `significant` | `notable`
3. **Write the entry JSON** to `.vibememo/users/{username}/entries/NNN_short_descriptor.json` following the v2 schema in [references/FORMAT.md](references/FORMAT.md)
4. **Update the user index**
5. **Update narratives**:
   - **User narrative** (`.vibememo/users/{username}/vibememo.md`): Update when a `critical` entry is created or the user's work arc shifts
   - **Project narrative** (`.vibememo/vibememo.md`): Follows **eventual consistency** — updates only at these checkpoints:
     1. During narrative compaction pass 2 or 3
     2. On commit (triggered by PreToolUse hook)
     3. On session end (triggered by Stop hook)
6. **Include refs**: Link to related entries and affected files

## Entry Quality Standards

- **`why` must be specific.** Not "because it's better." Say what constraint, tradeoff, or evidence drove the decision.
- **`implications` must be forward-looking.** "This means that in 6 months..." or "This constrains future choices because..."
- **`alternatives_considered` must be real.** Include options that were actually discussed, not strawmen.
- **`confidence` must be honest.** If uncertain, say `medium` or `low`. This helps future readers know which decisions are load-bearing vs. provisional.
- **`revisit_trigger` is important.** Under what condition should someone reconsider this?

## Narrative Guidelines

The narrative (`vibememo.md`) is the primary artifact — what humans read. It should:

- Read like a senior engineer telling a new team member how this project came to be **and why it was built this way**
- Be chronological but compressed — skip the boring parts
- **Always preserve the "why" behind decisions.** Architecture can be read from code. Reasoning cannot. The "why" is the last thing to compress, ever.
- Include pivots and the reasoning for the reversal, not just the final state
- Target 800-1500 words. Hard ceiling 2000 words. When over ceiling, follow the compress-then-version cycle in [references/FORMAT.md](references/FORMAT.md).
- Reference important JSON entries inline: `→ [023](users/{username}/entries/023_database_selection.json)`

### Eventual Consistency for Project Narrative

In a team environment, updating the project narrative on every entry is expensive. The project narrative (`.vibememo/vibememo.md`) synthesizes across all users and updates only at consistency checkpoints:

1. **Compaction pass 2+** — when any user narrative is being compressed
2. **On commit** — before the commit lands, synthesize all user narratives
3. **On session end** — ensure the project narrative reflects all work done this session

This means the project narrative may lag behind individual user narratives during active work, but is guaranteed fresh at every commit and session boundary.

## Tone

Direct. Opinionated. Honest about uncertainty. Not corporate. Not filler. If a decision was made under uncertainty, say so. If a previous decision turned out to be wrong, say that too.

## References

- [FORMAT.md](references/FORMAT.md) — Full v2 format specification, entry schema, compaction algorithm
- [vibememo-eval.md](references/vibememo-eval.md) — Companion evaluation skill with 9-dimension quality scoring
- [hooks.md](references/hooks.md) — Hook configurations for commit reminders, session-end eval, and narrative consistency
