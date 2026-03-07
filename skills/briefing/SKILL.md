---
name: briefing
description: Morning intelligence brief — calendar, emails, Slack signals, Jira blockers, OKR pulse, supplier health, team pulse, open decisions, open todos, and a ranked focus list. Use when starting the day or when the user wants a status overview.
---

# Morning Briefing

You are preparing the user's daily intelligence brief. This brief should take under 3 minutes to read and give complete situational awareness before the first meeting.

## Setup

Before collecting data, read:
- `config/profile.md` — user's name, role, company
- `config/team.md` — direct reports (names, areas) and stakeholders
- `config/domain.md` — key systems, suppliers, terminology
- `config/integrations.md` — which MCP tools and Jira project keys are configured

Use these config files to drive all scanning below. Suppress sections for unconfigured integrations.

---

## Data Collection

Run ALL of the following in parallel before writing anything. Gather everything first, then synthesise. Skip any source not configured in `config/integrations.md`.

### 1. Calendar
- Fetch today's full calendar
- Fetch tomorrow's calendar (advance awareness)
- Count today's meetings — determine load: 4+ = heavy, 2-3 = moderate, 0-1 = light
- For each meeting: identify if it is a 1-2-1 with a direct report or stakeholder (from config/team.md)
- For each of today's meetings: check memory (`memory/people.md`, `memory/projects.md`) for context on attendees, open actions, and recent decisions
- Check if any high-stakes meeting (boss, all-hands, external partner) starts within 90 minutes of current time
- Check if today is a sprint start or planning day from `memory/recurring.md`
- Flag: back-to-backs, external participants, meetings with no prep note in memory from last 3 days

### 2. Gmail — last 24 hours
- Search unread emails from the last 24 hours
- Prioritise: stakeholders and direct reports (from config/team.md), any supplier/partner domains
- Flag threads with 5+ replies
- Urgency keywords: "urgent", "blocker", "escalation", "P0", "P1", "down", "broken"
- Approval keywords: "sign off", "approve", "your call", "need your decision", "waiting on you", "escalating to you", "only you can"
- Separate: (a) requires user's decision/approval, (b) needs a reply, (c) FYI

### 3. Slack — last 24 hours
- Search for user's mentions (`to:me`) in the last 24 hours
- Search for DMs from direct reports in the last 24 hours
- Search for urgency keywords: "blocker", "urgent", "escalation", "down", "broken", "P0", "P1"
- Search for approval keywords (same as Gmail above)
- Search for supplier signal keywords: each supplier name (from `memory/suppliers.md` or `config/domain.md`) combined with: "down", "timeout", "error", "failing", "degraded", "outage", "slow", "issue"
- Flag: after-hours DMs from direct reports (unusual = likely urgent), threads with 3+ emoji reactions

### 4. Jira — blocked and overdue (skip if not configured)
- Search for blocked tickets across configured Jira project keys (from `config/integrations.md`)
- Search for tickets overdue or in-progress >14 days without update
- **For each blocked ticket: capture the ticket creation date and last-update date** — this is required for stale detection
- Flag: anything assigned to the user directly, anything with escalation label, P0/P1 priority

### 5. Open Todos
- Fetch all open todos from the Notes app
- Note which are time-sensitive or connect to today's calendar

### 6. Memory — baseline context
- Read `memory/people.md` — note open actions >14 days old per person
- Read `memory/projects.md` — note any projects with blockers or at-risk status
- Read `memory/okrs.md` — note OKR status: which KRs are red/amber/green and last update date
- Read `memory/decisions.md` — extract entries with no resolution date or marked "Decision needed" / "Pending"
- Read `memory/suppliers.md` — note any supplier entries currently flagged red or amber
- Read `memory/recurring.md` — check if today is a sprint planning or sprint start day

### 7. Decisions scan (from memory)
Already covered in Step 6. Surface any `decisions.md` entries with no resolution and a decision-owner of the user or marked as pending their input.

### 8. Supplier signal scan — 24 hours (skip if no suppliers configured)
Targeted search: combine each supplier name from `memory/suppliers.md` with failure-signal words in Slack (last 24h). Cross-reference with `memory/suppliers.md` status flags. This is a lightweight check — not a full `/supplier-watch`.

### 9. Confluence — 48 hours, targeted (skip if not configured)
Search for Confluence pages modified in the last 48 hours by anyone named in `memory/people.md`. Limit to configured spaces. Max 5 results. Surface only in Patterns section if relevant.

---

## Convergence Detection

Before writing, scan across all sources for:
- Same topic or person appearing in 2+ sources in the last 48h → surface as a pattern
- A direct report mentioned in both email and Slack → likely needs attention
- A supplier mentioned in both Jira and Slack → potential incident
- A Confluence page update that relates to a Slack thread or email in the same period

---

## Output Format

Write in this exact section order. Apply all suppression rules below before writing. Keep every section tight — bullets only, no prose paragraphs.

Read the user's name from `config/profile.md` for the greeting.

```
# Good Morning, [User Name]
**[Full date] | [Day of week]**
[DAY MODE — render only on Monday or Friday, suppress all other days:]
[Monday]: "Week start. Set your 3 priorities."
[Friday]: "Week close. Consider running /weekly-retrospective before EOD."

---

## 🎯 Requires You
[CONDITIONAL — suppress this entire section, including the header, if nothing found]
Actions only you can take — approvals, sign-offs, pending decisions.
- [Topic] — [Source: email/Slack/decisions.md] — [What's needed, 1 line] [Age if >3 days old]

---

## ⚡ Top 3 Right Now
The 3 most important things across all sources, ranked by urgency.
1. [Item — source — why it matters]
2. [Item — source — why it matters]
3. [Item — source — why it matters]

---

## 📅 Today's Schedule
**[X] meetings today — [heavy / moderate / light]**
[If high-stakes meeting within 90 mins: "⚡ [Meeting name] in [X] mins — consider running /stakeholder-brief [topic] now"]

[Time] **[Meeting title]** — [Key attendees]
  → [1-line prep note from memory, or "No prep needed"]
  → [If 1-2-1 detected and no prep note in last 3 days: "No prep found — run /prep-1-2-1 [Person] before this meeting"]

[Repeat per event]
[⚠️ Flag back-to-backs or external attendees if present]

**Tomorrow heads-up**: [1-2 key events worth knowing]

---

## 🔴 Needs Your Response
[Split into tiers only when both tiers have items. Otherwise use a single list.]

**Today** (deadline-linked or time-sensitive):
- **[Sender]** ([source]): [Subject] — [What's needed, 1 line]

**This week** (important but not time-critical):
- **[Sender]** ([source]): [Subject] — [What's needed, 1 line]

[If empty: "Inbox clear — nothing urgent needs a reply."]

---

## 📊 OKR Pulse
[If all KRs are 🟢: "All KRs on track — last updated [date from okrs.md]. Run /okr-update for live data."]
[If any KR is 🔴 or 🟡, show ONLY at-risk rows:]
| KR | Owner | Status | Note |
|----|-------|--------|------|
| [Abbreviated KR title] | [PM] | 🔴/🟡 | [1-line note] |
→ Run /okr-update for full dashboard.
[If okrs.md is empty/template: "OKR data not yet loaded — run /okr-update to seed."]

---

## 👥 Team Signals
**Direct Reports** (from config/team.md)
[One line per direct report:]
- **[Name]**: [signal or "No signals"]

[If any skip-level reports are configured in config/team.md, only render them if there's a signal worth surfacing.]

---

## 🚨 Blockers & Risks
[CONDITIONAL — suppress if Jira not configured and no blocker signals from other sources]
[For each blocked ticket, apply stale labelling:]
- [Normal] [Ticket] — [Owner] — [Why it matters] (blocked <7 days)
- AGING: [Ticket] — [Owner] — [Why it matters] ([X] days)
- STALE: [Ticket] — [Owner] — [Why it matters] ([X] days — escalate?)

[If none: "No active blockers flagged."]

---

## 🏨 Supplier Signals
[CONDITIONAL — suppress this entire section, including the header, if nothing found or no suppliers configured]
- **[Supplier name]** — [Source: Slack/suppliers.md] — [1-line description]
→ Run /supplier-watch for full health dashboard.

---

## 📋 Open Todos ([count])
- ⭐ [Time-sensitive or connected to today's meetings]
- [Regular todos]

---

## 📬 FYI Only
- [Sender]: [Subject] — [1-line summary]

---

## 🔁 Patterns Worth Noting
[CONDITIONAL — suppress this entire section, including the header, if no convergence detected]
- [Topic/person] seen in [source A] and [source B] — [what this might mean]
```

---

## Guiding Principles

**Signal and priority:**
- Lead with "Requires You" and "Top 3" — these frame the whole day before anything else is read
- If a meeting attendee has open actions in memory, surface them in the schedule prep note
- Connect dots unprompted: if an email is about a meeting happening today, say so
- Reserve 🔴 for genuine action items — do not use it for FYI-level items

**Suppression rules — strictly observed:**
- Conditional sections (Requires You, Supplier Signals, Patterns) are suppressed entirely — header and all — when empty. Write nothing, not even a placeholder.
- Day Mode renders only on Monday and Friday. Other days: no Day Mode block at all.
- OKR Pulse renders as a single line when all KRs are green. Only expand to a table when something is amber or red. Never show green rows in the table.
- Response tier sub-headers ("Today" / "This week") only appear when both tiers have items. Single group otherwise.
- Patterns section header is suppressed when nothing to show.

**Stale blocker labelling:**
- <7 days blocked: normal format
- 7–13 days blocked: prefix AGING:
- 14+ days blocked: prefix STALE: and append "(X days — escalate?)"

**Format:**
- Bullets only — no prose paragraphs in output
- Every item should have a clear "so what"
- If a section has nothing to show, say so in one line or suppress it — never pad
- Total output should take under 3 minutes to read
