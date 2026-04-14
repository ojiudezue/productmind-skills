# VibeMemo Format v2

> An open format for capturing the decision trail of software projects.

## Overview

VibeMemo captures the inner story of how and why code was built — decisions, alternatives considered, implications, counseling moments, and pivots. It's the flight data recorder for software development.

The format is **open and free to implement.** Any tool can write `.vibememo` data. The value is in the tooling that reads, synthesizes, and counsels — not in the format itself.

## Design Principles

1. **vibememo.md is the artifact.** It's what humans read. It's what the read-side product ingests. Everything else is backing data.
2. **"Why" is the core value.** Architecture can be read from code. The reasoning behind decisions cannot. Every entry must capture *why* a decision was made. The "why" is the last thing compressed and the first thing preserved. If a narrative loses "why," it has failed.
3. **Per-user, checked in, visible to all.** Each developer owns their namespace. Pull to see everyone's trail.
4. **JSON is continuous. Narrative is periodic.** JSON entries capture decisions as they happen. Narratives are synthesized on commit (or on a loop) — not on every entry.
5. **High bar, not low.** Only load-bearing decisions get entries. The narrative bar is even higher — it stays concise across any timescale.
6. **Travel with the code.** `.vibememo/` is committed to the repo. Clone the repo, get the decision trail.

## File Structure

```
.vibememo/
├── FORMAT.md                              # This spec
├── settings.json                          # Project-level VibeMemo settings
├── vibememo.md                            # Project narrative (synthesized from all users)
├── vibememo_v1.md                         # Archived narrative (when current exceeds threshold)
│
├── users/                                 # All per-user namespaces
│   ├── {username}/                        # Per-user namespace (git username)
│   │   ├── vibememo.md                    # This user's narrative of their work
│   │   ├── entries/                       # This user's decision entries
│   │   │   ├── 001_short_descriptor.json
│   │   │   ├── 002_short_descriptor.json
│   │   │   └── ...
│   │   └── index.json                     # This user's entry index
│   │
│   └── {username2}/                       # Another developer
│       ├── vibememo.md
│       ├── entries/
│       └── index.json
│
└── .vibememorc                            # Local-only settings (gitignored)
```

## Entry Schema (v2)

```json
{
  "format_version": "2.0",
  "entry_id": "NNN",
  "author": "git username",
  "session_id": "string — groups entries from one working session",
  "timestamp": "ISO 8601",
  "type": "decision | observation | counseling | milestone | pivot",
  "weight": "critical | significant | notable",

  "title": "One-line summary",
  "summary": "2-3 sentence plain-English description",

  "decisions": [
    {
      "id": "entry_id.N",
      "category": "architecture | stack | brand | product | security | deployment | data_model | ux | pricing | process",
      "decision": "What was decided",
      "alternatives_considered": ["Alternative 1", "Alternative 2"],
      "why": "Why this choice was made — specific constraint, evidence, or tradeoff",
      "implications": "What this means going forward — the 3/6/12 month view",
      "confidence": "high | medium-high | medium | low",
      "revisit_trigger": "Condition under which this should be reconsidered",
      "supersedes": "entry_id of decision this replaces, if any"
    }
  ],

  "counseling": [
    {
      "type": "security | architecture | scalability | cost | consistency",
      "severity": "high | medium | low",
      "message": "What was flagged",
      "resolution": "accepted | overridden | deferred",
      "reasoning": "Why the user accepted or overrode"
    }
  ],

  "refs": {
    "what_prompted_this": "The trigger for this entry",
    "tools_in_use": ["claude_code", "cursor", "aider", "terminal"],
    "files_affected": ["path/to/file"],
    "related_entries": ["NNN"],
    "commits": ["sha — if associated with a specific commit"]
  },

  "meta": {
    "session_duration_minutes": 0,
    "ai_suggestions_accepted": 0,
    "ai_suggestions_modified": 0,
    "ai_suggestions_rejected": 0,
    "security_flags_raised": 0,
    "consistency_flags_raised": 0
  }
}
```

## Entry Types

| Type | When | Weight guidance |
|------|------|----------------|
| `decision` | Architectural, technical, product, or strategic choice made | `significant` or `critical` |
| `observation` | Notable insight, risk, or pattern noticed — no action yet | `notable` |
| `counseling` | VibeMemo flagged a security, consistency, or implications issue | `significant` or `critical` |
| `milestone` | Significant deliverable completed | `significant` |
| `pivot` | Previous decision reversed or significantly changed | Always `critical` |

## Compaction Strategy

### Compaction rules (deterministic)

| Entry weight | First compaction | Second compaction | Archival |
|-------------|-----------------|-------------------|----------|
| `critical` | **Full detail preserved.** | Full detail preserved. | Full detail preserved. |
| `significant` | **Summarized to 1-2 sentences.** Decision + why + key implication. | **Summarized to 1 sentence. Decision + why.** | Referenced by link only. |
| `notable` | **Removed from narrative.** Only survives in JSON entries. | Removed. | Removed. |

### The Compress-Then-Version Cycle

```
1. COMPRESS PASS 1: Drop `notable` entries, summarize `significant` to 1-2 sentences.
   → If under 1500 words: done.

2. COMPRESS PASS 2: Summarize `significant` to 1 sentence (decision + why).
   → If under 1500 words: done.

3. COMPRESS PASS 3: Reduce `critical` entries to 2-3 sentences.
   → If under 1500 words: done.

4. DESTRUCTIVE LOSSINESS: Archive as vibememo_v{N}.md. Start fresh.
```

## Open Format Philosophy

The `.vibememo` format is open and free to implement. Any tool can read and write `.vibememo` data. The format is the protocol. The products are the implementations.
