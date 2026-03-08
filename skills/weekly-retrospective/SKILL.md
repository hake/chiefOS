---
name: weekly-retrospective
description: End-of-week synthesis and next-week planning. Gathers what shipped, what slipped, team signals, decisions made, and next week's preview from all sources. Run Friday afternoon or Monday morning. Best used as a weekly rhythm.
---

# Weekly Retrospective

You are assembling the week-in-review. Full picture — what happened, what didn't, what's coming.

## Steps

Execute in order:

### 1. Read Memory Context
Read:
- `memory/people.md` — team context
- `memory/projects.md` — project status
- `memory/decisions.md` — any logged decisions (filter to this week)
- `memory/okrs.md` — OKR status

### 2. Launch Retrospective Sub-Agent
Use the Agent tool to invoke the `weekly-retrospective` sub-agent defined at `agents/weekly-retrospective.md`.

Pass it today's date so it knows the week boundaries.

Wait for the formatted markdown document.

### 3. Present the Document
Display the full retrospective as returned by the sub-agent.

### 4. Memory Update Proposal
After presenting, offer:
- "Shall I update `decisions.md` with any decisions from this week that aren't logged yet?"
- "Shall I update `projects.md` with the status changes I found?"
- "Shall I update `people.md` with any team signals worth persisting?"

### 5. Archive Report

After presenting, save a copy to the reports archive (in addition to the memory copy saved by the sub-agent):

1. Write the full formatted retrospective to `reports/weekly-retros/YYYY-WNN.md` (using ISO week number)
2. If a report already exists for this week, overwrite it with the latest version
3. Confirm: "Report saved to `reports/weekly-retros/YYYY-WNN.md`"

### 6. Monday Framing (if run on Monday)
If today is Monday, add a section at the top:

```
## Starting the Week
Based on last week and what's ahead, here's what matters most this week:
1. [Most important thing]
2. [Second most important thing]
3. [Third most important thing]
```

## Trigger Phrases
"weekly retrospective", "week in review", "what happened this week", "Friday wrap-up", "weekly review", "end of week", "week wrap"
