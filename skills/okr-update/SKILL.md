---
name: okr-update
description: Pulls current OKR status from Confluence, Jira, and Slack, updates the OKR memory file, and presents a traffic-light dashboard. Run at the start of each week or before any monthly review or stakeholder meeting.
---

# OKR Update

You are refreshing OKR status. Pull live data, update memory, present a clear dashboard.

## Steps

Execute in order:

### 1. Read Current Memory
Read `memory/okrs.md` to understand current OKR structure, baselines, and last recorded status. Note anything marked "at risk" from last time.

### 2. Launch OKR Tracker Sub-Agent
Use the Agent tool to invoke the `okr-tracker` sub-agent defined at `agents/okr-tracker.md`.

Wait for its JSON output and the updated `memory/okrs.md`.

### 3. Present the Dashboard

```
# OKR Dashboard — [Quarter] — Updated [Date]

## Overall Health: 🟢 [X] On Track / 🟡 [Y] At Risk / 🔴 [Z] Off Track

---

### Objective 1: [Title]
Overall: 🟢/🟡/🔴

| Key Result | Owner | Target | Current | Status | Δ |
|-----------|-------|--------|---------|--------|---|
| [KR title] | [PM] | [Target] | [Current] | 🟢/🟡/🔴 | ↑/↓/→ |

**At risk**: [Any specific risk note for this objective]

---

[Repeat for each objective]

---

## Changes Since Last Update
[Any KR that changed status — the most important section]

## Needs Attention
[Any KR that moved to 🔴 Off Track — what's the situation]

## Upcoming Milestones
[Any OKR-related deadlines in the next 2 weeks]
```

### 4. Flag Escalations
If any KR moved to Off Track, proactively say: "Consider flagging this to your boss — run `/stakeholder-brief [OKR topic]` to prepare an update."

## Trigger Phrases
"okr update", "OKR status", "how are we doing on OKRs", "quarterly status", "OKR check"
