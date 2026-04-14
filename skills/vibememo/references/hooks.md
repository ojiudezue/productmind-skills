# VibeMemo Hook Configurations

Hooks enforce VibeMemo's consistency model automatically. Add these to your `.claude/settings.json` (or equivalent for your agent).

## Pre-Commit Hook

Reminds the agent to check for uncaptured decisions before any `git commit`. This is a consistency checkpoint — the agent should run vibememo-eval Part 1 and synthesize the project narrative before the commit lands.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.command // \"\"' | grep -q 'git commit' && printf '{\"systemMessage\":\"VibeMemo: Before committing, check for uncaptured decisions. Run /vibememo if needed.\"}' || printf '{}'",
            "statusMessage": "VibeMemo: checking..."
          }
        ]
      }
    ]
  }
}
```

## Session-End Hook

Triggers a full vibememo-eval (Part 1 + Part 2) when the session ends. This is a consistency checkpoint — the agent should capture any remaining decisions and synthesize the project narrative.

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "printf '{\"systemMessage\":\"VibeMemo session-end: Run /vibememo-eval (Part 1 + Part 2) before closing. Capture uncaptured decisions, then score all 9 eval dimensions.\"}'",
            "statusMessage": "VibeMemo: session-end eval..."
          }
        ]
      }
    ]
  }
}
```

## Loop Setup

For periodic capture checks during active sessions, set up a 30-minute loop:

```
/loop 30m /vibememo-eval
```

This runs Part 1 (capture check) every 30 minutes, with a full Part 2 eval every 3rd invocation. If nothing happened, it produces no output.

## Consistency Model

VibeMemo uses **eventual consistency** for the project narrative. Individual user narratives update on every critical entry, but the project narrative (which synthesizes across all users) only updates at these checkpoints:

| Checkpoint | What updates | Trigger |
|-----------|-------------|---------|
| Entry creation | User narrative (if critical/arc shift) | `/vibememo` or auto-detect |
| Compaction pass 2+ | User narrative + project narrative | Narrative exceeds word ceiling |
| Commit | User narrative + project narrative | PreToolUse hook on `git commit` |
| Session end | User narrative + project narrative | Stop hook |
| Loop (30m) | User narrative only (if new entries) | Cron/loop scheduler |

This means the project narrative may lag during active work but is guaranteed fresh at every commit and session boundary — the points where other developers will actually see the changes.
