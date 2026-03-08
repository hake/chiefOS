---
name: daily-ops
description: >
  This skill provides patterns for daily and weekly operational routines.
  Use when the user says "daily briefing", "morning update", "what's on today",
  "weekly review", "weekly catchup", "week summary", "what happened this week",
  or runs the /daily-briefing or /weekly-catchup commands.
version: 0.1.0
---

# Daily Ops — Routines & Patterns

## Setup

Before generating, read:
- `config/profile.md` — user's name, role, company
- `config/team.md` — direct reports and stakeholders

## Daily Briefing Pattern

The morning briefing should be a quick-scan document that takes under 2 minutes to read. Priorities:

1. **Time-sensitive items first** — meetings that need prep, deadlines, blockers
2. **People items second** — what do direct reports need from the user today?
3. **Information items third** — FYIs, updates, trends

### Source Priority for Daily Briefing
1. Google Calendar (today's schedule) — always first
2. Slack DMs and mentions (last 24h) — urgent communications
3. Gmail (unread, last 24h) — especially from team and stakeholders
4. Open todos — carry-forward items (use configured notes app per `config/integrations.md` and `core/notes-integration.md`; skip if `notes_app` is `none`)

### Signal Detection
Flag as "needs attention" if:
- A direct report sent a DM after hours (unusual = likely urgent)
- Multiple people are discussing the same topic (convergence = something's happening)
- An email thread has 5+ replies (escalation signal)
- A Slack message has 3+ emoji reactions (community signal)
- Any message contains: "blocker", "urgent", "escalation", "down", "broken", "P0", "P1"

## Weekly Catchup Pattern

The weekly catchup is a reflection + planning document. It should answer:
1. **What happened?** — Key decisions, outcomes, surprises
2. **How is the team?** — One-liner per direct report on their state
3. **What's at risk?** — Blockers, overdue items, resource issues
4. **What's next?** — Preview of next week's priorities

### Best Day to Run
- Friday afternoon (end-of-week reflection)
- Monday morning (combined with daily briefing for week kick-off)

### Cadence Awareness
Track patterns across weeks:
- Are the same blockers appearing repeatedly? → Systemic issue
- Is one person consistently raising concerns? → May need support
- Are action items aging? → Execution gap

## Tone Guidelines

All outputs should match the user's communication style (from `memory/comms-style.md`):
- Direct and concise — no corporate fluff
- Actionable — every item should have a clear "so what"
- People-first — team health matters as much as delivery metrics
- Strategic context — connect daily tasks to quarterly goals where relevant
