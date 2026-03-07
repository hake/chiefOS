---
name: meeting-actions
description: Post-meeting action extraction. Scans calendar, email, and Slack for action items from recent meetings. Evaluates each action's owner and relevance, then adds items to your todo list and updates people memory. Run after any meeting, batch of meetings, or at end of day.
argument-hint: "[optional: meeting name or time window like '2h']"
---

# Meeting Actions

You are extracting action items from recent meetings. Find every commitment, evaluate who owns it, and make sure nothing falls through the cracks.

## Arguments
`/meeting-actions` — scans meetings from the past 4 hours
`/meeting-actions [N]h` — scans past N hours (e.g. "2h", "8h")
`/meeting-actions [meeting name]` — scans a specific meeting by name

## Steps

Execute in order:

### 1. Read Context
Read:
- `config/profile.md` — user's name (to identify actions assigned to them)
- `config/team.md` — direct reports and stakeholders
- `memory/people.md` — current open actions per person (to avoid duplicates)

### 2. Launch Meeting Actions Sub-Agent
Use the Agent tool to invoke the `meeting-actions` sub-agent at `agents/meeting-actions.md`.

Pass it:
- The time window (default: 4 hours, or as specified)
- Meeting name filter if specified
- Current open actions from memory (to avoid duplicates)

Wait for its JSON output.

### 3. Present What Was Found

```
# Meeting Actions — [Date, Time]

## Meetings Scanned
[List of meetings found with time and attendees]

---

## 🎯 Your Actions ([count])
Items you need to do:

| # | Action | From Meeting | Deadline | Urgency |
|---|--------|-------------|----------|---------|
| 1 | [Action description] | [Meeting name] | [Date or —] | 🔴/🟡/🟢 |

---

## 👥 Track These (delegated to your team)
Items your direct reports own — tracked for follow-up:

| # | Owner | Action | From Meeting | Deadline |
|---|-------|--------|-------------|----------|
| 1 | [Person] | [Action] | [Meeting] | [Date or —] |

---

## ℹ️ FYI
[Brief list of actions owned by others that are good to know about]

---

## ❓ Needs Clarification
[Actions where ownership or scope was ambiguous — confirm with attendees]
- [Ambiguous item] — *Who owns this?*
```

### 4. Confirm Todo Creation
After presenting, say:

"I've added [X] items to your todos and updated `people.md` with [Y] actions for your team. Want me to adjust any of these?"

### 5. Handle Clarifications
If there are ambiguous items, ask: "Can you clarify ownership for the items under 'Needs Clarification'? I'll add them once confirmed."

## When to Run
- After any 1-2-1 or team meeting
- At the end of a meeting-heavy day (use `/meeting-actions 8h`)
- After important cross-functional meetings
- As part of `/daily-ops` wrap-up

## Trigger Phrases
"meeting actions", "extract actions", "what came out of that meeting", "post-meeting todos", "capture meeting actions", "what do I need to do after that meeting", "meeting follow-ups"
