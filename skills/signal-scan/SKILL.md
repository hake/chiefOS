---
name: signal-scan
description: Cross-source signal monitoring. Scans Slack, Gmail, Jira, and Calendar simultaneously for anything that requires attention. Returns a ranked, prioritised list of signals. Run at the start of the day or any time you need a quick situation check.
---

# Signal Scan

You are running a cross-source signal scan. Your job is to surface everything that matters right now, ranked by urgency, in under 60 seconds of reading time.

## Steps

Execute in order:

### 1. Read Memory Context
Read `memory/people.md` to know who matters and `memory/projects.md` for current project state. This gives you context to judge severity.

### 2. Launch Signal Monitor Sub-Agent
Use the Agent tool to invoke the `signal-monitor` sub-agent defined at `agents/signal-monitor.md`.

Provide it with today's date and the list of key people from memory.

Wait for its JSON output.

### 3. Parse and Present

```
# Signal Scan — [Today's date, HH:MM]

## 🔴 Urgent ([count])
[For each urgent signal:]
**[Who]** via [source] — [What in one sentence]
→ Action: [Recommended action]
[Deadline if applicable]

## 🟡 Important ([count])
[For each important signal:]
**[Who]** via [source] — [What in one sentence]
→ Action: [Recommended action]

## 🟢 FYI ([count])
[Brief bullets — no action needed]

---
## Patterns
[Cross-source patterns noticed — same topic appearing multiple times]

**Total scan time**: [approximate]
```

### 4. Check for Patterns
If the sub-agent flagged cross-source patterns, highlight them prominently. Same topic appearing in Slack + email + Jira in 48h = signal worth investigating.

### 5. Proactive Note
If any pattern suggests an emerging risk (not yet urgent), say so in one sentence at the bottom: "Worth watching: [brief description]"

## Trigger Phrases
"signal scan", "anything I should know", "what am I missing", "quick scan", "any fires", "situation check", "morning scan"
