# auto-kanban

A capture-first kanban board for agent-driven software work. One YAML file is the source of
truth; markdown and HTML views are rendered from it; the release script marks cards shipped as
part of the deploy flow, so the board can never quietly rot behind the code.

## Why capture-first beats chat memory

An AI agent's working context is not a database. As a session runs, the context compresses and
compacts: *decisions* tend to survive, but *texture* does not — the exact phrasing of a
request, a constraint stated in passing, a rejected alternative, and the origin pointer (which
message an item came from). When the agent later writes a plan "from memory," everything that
scrolled out is reconstructed from a summary of a summary. That is how:

- a user's aside ("also, that export should never auto-send") silently disappears,
- an option you explicitly rejected comes back three sessions later as a fresh proposal,
- the agent's own mid-turn discovery — a bug it noticed inside a tool result — is never acted
  on, because nothing ever re-raises it.

The fix is not better memory, it's a different rule: **every user push and every agent mid-turn
discovery becomes a card in the same turn, before acting.** Once an item is a card in a
committed file, it survives compaction, session restarts, and model swaps. The transcript can
decay; the board cannot.

## Install

Copy the skill into your project (or user-level) skills directory:

```bash
cp -r skills/auto-kanban /path/to/your/project/.claude/skills/auto-kanban
```

Or reference it from a plugin/marketplace setup your agent supports. The skill is
self-contained — no dependencies beyond a YAML parser for the optional render script.

## Quickstart

1. Create `docs/kanban.data.yaml` in your repo:

   ```yaml
   meta:
     last_reconciled: '2026-01-01'
     columns: [inbox, pre_planning, planned, in_progress, review, shipped,
               waiting_user, waiting_agent, parked]
   cards: []
   ```

2. Load the skill at session start. From then on, every request you make and every idea the
   agent floats mid-turn gets captured as a card before the agent acts on it.
3. Before any planning doc, the agent harvests the relevant cards (origin, why, constraints,
   rejected alternatives) into the plan.
4. Wire the ship gate: make your release script require `--cards ID[,ID...]` — refusing to
   deploy without it (with an explicit, logged `--no-cards` escape for docs-only releases) —
   and write `status: shipped` + the version onto those cards after a successful push.

Every card carries a **plain-language `problem_solution`** (Problem: … Solution: …) written for a
reader who wasn't in the room — jargon and file refs go in `refs`, not the framing — plus
`created`/`updated` timestamps and a `refinement_status` (initial vs refined) so staleness and
maturity show at a glance.

See `SKILL.md` for the full card schema, cadence, and anti-patterns. An annotated example data
file lives at `references/schema/kanban.data.example.yaml`, and a self-contained demo board
(light/dark, STALE banner, disposition buttons) at
`references/dashboard/board.example.html`.

## Operator dispositions — drive the board without the agent

Once the board is hosted, the human will read it while the agent is offline. Each card on the
demo board carries `done` / `deferred` / `declined` buttons — and early-stage (intake) cards
add **`approve`** (out-of-band go-ahead with the same authority as an in-chat "yes") and
**`investigate`** (flags the card for the next bounded triage sweep). Buttons POST a
`{card_id, action, at}` line to an append-only queue file — never editing the YAML directly.
At the next session start the agent applies the queue with operator authority (apply, don't
relitigate), deletes it, re-renders, and commits. One-way, human → agent.

**The apply step is force-gated, not remembered:** the render script's `--check` mode exits
with a distinct non-zero code while the queue is non-empty, so a session cannot report status
past an unapplied button-tap. (A pending chip on the page is a banner; the exit code is the
mechanism.)

## Intake hygiene — bounded lull investigation

Uninvestigated intake cards are phantom load: they look like work while nobody knows if
they're duplicates, already shipped, config-only, or real. During lulls, the agent sweeps
intake cards through a context-wide investigation under a hard token budget (one agent per
card, no fan-out, a per-lull cap) and records one of six verdicts — duplicate/adjacent,
already-shipped, config-only, dead, real, or unresolved-in-budget. An investigated card moves
or closes; it never returns to plain intake.

## Watch results write back

When a shipped card's live validation lands (confirmed / violated / pending), the result is
written back onto the card the same session — confirmed evidence accumulates on the card,
a violation returns the card to review. The board, not a monitoring report, is where
"is it actually done?" gets answered.

## Drive a simple web page

The board is just data, so a live web view is a ~100-line render script away, in any language.
The pattern:

1. **Read the YAML**, group cards by `status`.
2. **Emit a single self-contained `board.html`** — inline CSS, no external assets — with one
   column per status and a color-coded chip per card.
3. **Regenerate on every data commit**, then serve `board.html` from any static host — GitHub
   Pages, an S3 bucket, a tiny web server on a spare box — or just open it locally in a
   browser. When multiple clones or worktrees edit the repo, a **cron pull-and-render job on
   the hosting machine is more robust than git hooks**: hooks fire per-clone and someone is
   always missing one, while a dumb pull-and-render loop every few minutes converges no matter
   who committed. The whole hosting pattern is: static file + tiny server + cron refresh.
4. **Staleness banner:** compare `meta.last_reconciled` against the newest git tag or release
   notes file; if the repo has moved past the board, render a loud banner across the top of the
   page. The page tells you it's stale — nobody has to remember to ask.

An example card:

```yaml
- id: EXPORT-1
  title: CSV export mangles unicode -> use utf-8-sig encoding
  thread: exporter
  status: in_progress
  origin: {date: '2026-01-05', gist: user report of garbled names in Excel}
  why: Excel assumes cp1252 without a BOM; utf-8-sig is the compatible fix
  next: add regression test with non-ASCII fixture
  refs: [docs/plans/export-fix.md]
```

And a sketch of the render loop (Python, illustrative):

```python
import yaml, html

data = yaml.safe_load(open("docs/kanban.data.yaml"))
cols = {c: [] for c in data["meta"]["columns"]}
for card in data["cards"]:
    cols.setdefault(card["status"], []).append(card)

COLORS = {"in_progress": "#e8a33d", "review": "#7d6bd0", "shipped": "#3a9a5c",
          "parked": "#8a8a8a", "inbox": "#4a90d9"}

out = ["<style>body{font-family:sans-serif;display:flex;gap:1rem}"
       ".col{flex:1;background:#f4f4f6;border-radius:8px;padding:.5rem}"
       ".card{background:#fff;border-left:4px solid var(--c);border-radius:6px;"
       "padding:.5rem;margin:.5rem 0}</style>"]
for name, cards in cols.items():
    out.append(f'<div class="col"><h2>{name} ({len(cards)})</h2>')
    for c in cards:
        color = COLORS.get(c["status"], "#666")
        out.append(f'<div class="card" style="--c:{color}">'
                   f'<b>{html.escape(c["id"])}</b> {html.escape(c["title"])}'
                   f'<br><small>next: {html.escape(c.get("next", ""))}</small></div>')
    out.append("</div>")
open("board.html", "w").write("".join(out))
```

Add the staleness comparison and a history file as you grow into them; the core loop stays
this small.
