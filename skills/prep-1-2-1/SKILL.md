---
name: prep-1-2-1
description: >
  Prepare for a 1-2-1 meeting with any person. Searches past meeting notes in your
  configured notes app, pulls open actions from memory, scans Slack and email for
  fresh context, and generates a pre-populated agenda. Use when the user says
  "prep my 1-2-1", "prepare meeting notes", "get ready for my 1:1 with [person]",
  "1-2-1 with [name]", or runs the /prep-1-2-1 command.
argument-hint: "[person name]"
---

# Meeting Prep — 1-2-1 Workflow

## Background Mode (Scheduled/Dispatched)
When running without a user present (see `core/platform.md`):
- Use memory and config data only — do not ask clarifying questions about the person
- If the person name doesn't match anyone in config/team.md, generate a best-effort prep from available sources
- Save output directly to `reports/prep-1-2-1/YYYY-MM-DD-[person].md`

## Setup

Before preparing, read:
- `config/team.md` — direct reports (names, areas, "what good looks like") and stakeholders
- `config/profile.md` — user's name for doc titles
- `config/integrations.md` — check `notes_app` value for where meeting notes are stored

Use these to identify the person being prepped for and their context.

## Meeting Notes Template

Every 1-2-1 note follows this structure (read user's name from `config/profile.md`):

```
# 1:1 [User Name] × [Person] — [DD MMM YYYY]

## Follow-up from Last Meeting
### [User]'s Actions
- [ ] [action item]

### [Person]'s Actions
- [ ] [action item]

## Recurring Themes
[Topics that appeared in 2+ consecutive meetings]

## Agenda
1. [Follow-up items]
2. [Fresh context items]
3. [Person]'s updates and blockers
4. [User]'s updates
5. New initiatives / priorities

## Notes
[Filled during the meeting]

## New Action Items
| Owner | Action | Due |
|-------|--------|-----|
|       |        |     |
```

## How to Find Past Meeting Notes

Read `config/integrations.md` for the `notes_app` value, then use `core/notes-integration.md` for the correct search tool.

Search order:
1. **Notes app** — Search for: `1:1 [user name] [person name]` or `1-2-1 [person name]` (skip if `notes_app` is `none`)
2. **Memory** — Check `memory/people.md` for open actions and recent context on this person
3. If no structured notes exist, check Slack DMs with the person for informal follow-ups

## Action Item Detection

When scanning past meeting notes:
- `- [ ] ...` = pending
- `- [x] ...` = done
- Lines starting with "ACTION:" or "TODO:"
- Items in the "Action Items" or "New Action Items" table

An action is **overdue** if it's pending and the meeting date is more than 14 days ago.

## Agenda Pre-population Rules

Priority order:
1. **Overdue action items** — always first
2. **Pending action items from last meeting** — quick status check
3. **Fresh context** — anything from Slack or recent meetings relevant to this person's area
4. **Recurring themes** — same topic in 2+ meetings = pattern worth addressing
5. **Standard items** — person's updates, user's updates, new priorities

## Naming Convention

Note title: `1:1 [User Name] × [Person] — [DD MMM YYYY]`
