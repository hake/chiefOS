---
name: meeting-prep
description: >
  Prepare for any meeting — team syncs, cross-functional, external, planning sessions,
  or stakeholder reviews. Pulls calendar context, researches attendees and topics, checks
  memory for relevant history, and generates a prep brief with talking points. For 1-2-1s,
  use /prep-1-2-1 instead.
argument-hint: "[meeting name or time, e.g. 'product review' or '2pm']"
---

# Meeting Prep — General Meetings

You are preparing the user for an upcoming meeting. Unlike `/prep-1-2-1` (which handles recurring 1-2-1s with action tracking), this skill handles all other meetings: team syncs, cross-functional reviews, external calls, planning sessions, stakeholder updates, etc.

## Non-Interactive Mode (Cowork)
When running in non-interactive mode (see `core/platform.md`):
- In Step 1: if the meeting argument is ambiguous, prep for the next upcoming meeting (do not ask which one)
- In Step 5: skip the follow-up offers ("Want me to draft talking points?", etc.) — just present the prep
- Save output directly to `reports/meeting-prep/YYYY-MM-DD-[meeting-slug].md`

## Setup

Before preparing, read:
- `config/profile.md` — user's name and role
- `config/team.md` — direct reports and stakeholders (to identify attendees)
- `config/domain.md` — key systems, suppliers, terminology
- `config/integrations.md` — which tools are configured, `notes_app` value

## Step 1: Identify the Meeting

If `$ARGUMENTS` is provided, find the matching meeting:
- Search today's and tomorrow's calendar for a meeting matching the name or time
- If ambiguous, list matches and ask which one

If no arguments, check:
- Is there a meeting starting within 90 minutes? → prep for that one
- Otherwise, list today's remaining meetings and ask which to prep for

Extract: **title, time, attendees, description/agenda (if any), recurring vs one-off**.

## Step 2: Classify the Meeting Type

Detect the type to shape the prep:

| Type | Signals | Prep Focus |
|------|---------|------------|
| **Team sync** | Attendees are mostly direct reports | Status updates, blockers, decisions needed |
| **Cross-functional** | Mix of teams, engineering partners | Alignment, dependencies, shared context |
| **Stakeholder / upward** | Boss or senior leadership attending | Strategic framing, key messages, risks to surface |
| **External** | Non-company attendees (vendors, partners) | Professional tone, no internal detail, objectives |
| **Planning** | Sprint, quarterly, roadmap in title | Data prep, metrics, priorities |
| **Ad-hoc / unknown** | None of the above | General context gathering |

## Step 3: Research Context (run in parallel)

### 3a. Attendee Context
For each attendee:
- Check `memory/people.md` — role, recent context, open actions
- If a direct report or stakeholder from `config/team.md`, note their area and "what good looks like"
- For unknown attendees, search Gmail and Slack for recent interactions

### 3b. Topic Research
From the meeting title and description, identify topics and search:
- **Memory** — `memory/projects.md`, `memory/decisions.md`, `memory/suppliers.md` for relevant entries
- **Notes app** — search for notes related to the meeting topic (use `core/notes-integration.md` for tool mapping; skip if `notes_app` is `none`)
- **Slack** (last 7 days) — threads related to the meeting topic or with attendees
- **Gmail** (last 7 days) — email threads related to the topic
- **Jira** (if configured) — relevant tickets, blockers, sprint status

### 3c. Meeting History
- Search notes app for past instances of this meeting (by title)
- Check if this is a recurring meeting from `memory/recurring.md`
- If recurring, surface: what was discussed last time, any open actions from previous sessions

## Step 4: Generate Prep Brief

```
# Meeting Prep: [Meeting Title]
**[Date] | [Time] | [Duration]**
**Type**: [Team sync / Cross-functional / Stakeholder / External / Planning]

---

## Attendees ([count])
- **[Name]** — [Role/area] [any relevant context: "has a blocker on X", "waiting on your approval for Y"]
- ...
[Flag any attendee you have open actions with]

---

## Context & Background
[2-3 bullet summary of what this meeting is likely about, based on title, description, and research]
- [Key context point from memory/Slack/email]
- [Recent development relevant to this meeting]
- [Any decision or blocker that connects to this topic]

---

## Your Talking Points
[Tailored to meeting type:]

**For team syncs:**
1. [Status check on X — from Jira/Slack signals]
2. [Decision needed on Y — surface from decisions.md]
3. [Blocker to discuss — from risk signals]

**For stakeholder/upward meetings:**
1. [Key message to convey — strategic framing]
2. [Risk to surface — with mitigation]
3. [Ask or decision needed from them]

**For external meetings:**
1. [Objective — what you want from this meeting]
2. [Key point to make]
3. [Question to ask them]

**For cross-functional:**
1. [Dependency or alignment topic]
2. [Your team's update — concise]
3. [Ask from the other team]

---

## Open Items with Attendees
[From memory/people.md — any pending actions involving attendees]
- [Person]: [open action] (age: X days)

---

## Questions to Raise
[Inferred from research — things worth asking]
- [Question 1 — why it matters]
- [Question 2]

---

## From Last Time
[If recurring meeting — what was discussed, any carry-forward items]
[If first time — "First occurrence of this meeting — no prior history"]
```

## Step 5: Offer Follow-ups

After presenting the prep:
- "Want me to draft any talking points in more detail?"
- "Should I pull specific data (metrics, ticket status) for any of these topics?"
- If stakeholder meeting: "Want me to run `/stakeholder-brief [topic]` for a polished brief?"
- If 1-2-1 detected: "This looks like a 1-2-1 — want me to use `/prep-1-2-1 [person]` instead for action tracking?"

## Trigger Phrases
"prep for my meeting", "prepare for", "get ready for the meeting", "meeting prep", "what do I need for the meeting", "brief me before the meeting", "prep the [meeting name]"
