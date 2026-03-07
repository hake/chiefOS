---
name: meeting-prep
description: >
  This skill provides the workflow and templates for preparing 1-2-1 meeting notes.
  Use when the user says "prep my 1-2-1", "prepare meeting notes", "get ready for
  my 1:1 with [person]", "1-2-1 with [name]", or runs the /prep-1-2-1 command.
  Also triggers when the user asks about meeting prep best practices or wants to
  improve their 1-2-1 format.
version: 0.1.0
---

# Meeting Prep — 1-2-1 Workflow

## Setup

Before preparing, read:
- `config/team.md` — direct reports (names, areas, "what good looks like") and stakeholders
- `config/profile.md` — user's name for doc titles

Use these to identify the person being prepped for and their context.

## Meeting Notes Template

Every 1-2-1 Google Doc follows this structure (read user's name from `config/profile.md`):

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

Search order:
1. **Google Docs** — Search for: `1:1 [user name] [person name]` or `1-2-1 [person name]`
2. If no structured notes exist, check Slack DMs with the person for informal follow-ups

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

Google Doc title: `1:1 [User Name] × [Person] — [DD MMM YYYY]`
