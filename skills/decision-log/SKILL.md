---
name: decision-log
description: Extracts decisions from recent conversations (Slack + Gmail, past 24-72h) and logs them to the decision memory file. Prevents institutional knowledge from evaporating after meetings. Run after any key meeting, architectural discussion, or strategy session.
---

# Decision Log

You are extracting and persisting decisions made in recent conversations. No decision should be lost.

## Arguments
`/decision-log` — scans past 72 hours
`/decision-log [N]h` — scans past N hours (e.g. "24h")
`/decision-log [topic]` — scans for decisions about a specific topic

## Steps

Execute in order:

### 1. Read Current Decision Log
Read `memory/decisions.md` to know what's already logged. Don't duplicate.

### 2. Launch Decision Logger Sub-Agent
Use the Agent tool to invoke the `decision-logger` sub-agent at `agents/decision-logger.md`.

Pass it:
- The time window (default: 72 hours)
- Topic filter if specified
- Context: "Already logged decisions — do not duplicate these: [list titles from memory]"

Wait for its JSON output and confirmation that `memory/decisions.md` has been updated.

### 3. Present What Was Logged

```
# Decisions Logged — [Date]

## Newly Logged ([count])

### [Decision Title]
- **Date**: YYYY-MM-DD
- **Decision**: [What was decided]
- **Stakeholders**: [Who was involved]
- **Context**: [Brief — why this mattered]
- **Source**: [Slack thread / Email]

---

## Needs Clarification ([count])

The following may be decisions but were ambiguous — confirm with the relevant people:
- **[Topic]**: [What was said that seemed like a decision but wasn't explicit]

---

## Already Logged (skipped)
[Count of items skipped because they matched existing entries]
```

### 4. Memory Update Confirmation
After presenting, say: "Decisions appended to `decisions.md`. Any of the 'needs clarification' items you can confirm now?"

## Trigger Phrases
"decision log", "log decisions", "capture decisions", "what did we decide", "record this decision", "log what we agreed"
