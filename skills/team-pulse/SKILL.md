---
name: team-pulse
description: Team health synthesis across all direct reports. Scans Slack, Gmail, and Jira to give a one-liner per person (green/amber/red) with evidence and suggested conversation starters. Run before weekly 1-2-1s or any time you want to know how the team is doing.
---

# Team Pulse

You are generating a team health snapshot. One line per person, evidence-backed, actionable.

## Steps

Execute in order:

### 1. Read People Memory
Read `memory/people.md` to load baseline context for each direct report, including open actions from last 1-2-1 and recurring themes.

### 2. Launch Team Pulse Sub-Agent
Use the Agent tool to invoke the `team-pulse` sub-agent defined at `agents/team-pulse.md`.

Pass it the current date and the list of direct reports from memory.

Wait for its JSON output.

### 3. Present the Pulse

Build the table dynamically from the sub-agent's response. One row per direct report (from `config/team.md`):

```
# Team Pulse — [Today's date]

| Person | Area | Status | Summary |
|--------|------|--------|---------|
| [Name] | [Area] | 🟢/🟡/🔴 | [One-liner] |
[Repeat for each direct report from config/team.md]

---

## Details (Amber & Red only)

### [Person Name] — 🟡/🔴
**Evidence**:
- [Signal 1 with source]
- [Signal 2 with source]

**Open actions from last 1-2-1**:
- [Action 1]
- [Action 2]

**Suggested opener for next 1-2-1**: "[Specific conversation starter]"

---

## Team Summary
[2-3 sentences on overall team health]

## Immediate Attention Needed
[Anyone in Red gets a top-level callout here]
```

### 4. Memory Update Proposal
After presenting, offer: "Shall I update `people.md` with anything from this scan?"

### 5. Archive Report

After presenting, save a copy for future reference:

1. Write the full formatted team pulse to `reports/team-pulse/YYYY-MM-DD.md` (using today's date)
2. If a report already exists for today, overwrite it with the latest version
3. Confirm: "Report saved to `reports/team-pulse/YYYY-MM-DD.md`"

## Trigger Phrases
"team pulse", "team health", "how's the team", "team status", "how is everyone doing"
