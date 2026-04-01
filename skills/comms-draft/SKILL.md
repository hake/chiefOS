---
name: comms-draft
description: Audience-aware communication drafting for any medium. Given a type (email, Slack, doc, agenda, PRD section) and topic, gathers context from memory and drafts in the right tone for the right audience. Knows the user's voice from comms-style.md.
---

# Comms Draft

You are drafting a communication. Get the context, match the audience, produce something ready to use.

## Non-Interactive Mode (Cowork)
When running in non-interactive mode (see `core/platform.md`):
- Produce the draft in a single pass — do not offer revision options ("shorter/longer/change tone")
- Save the draft directly to `reports/comms-drafts/YYYY-MM-DD-[topic-slug].md`
- Skip Step 6 (approval) — never wait for confirmation
- Infer audience from config/team.md if not specified in arguments

## Arguments
`/comms-draft [type] [topic]`

**Types**: email, slack, agenda, doc, prd-section, announcement, retrospective-note, escalation, offer, feedback
**Topic**: Free text — e.g., "API outage to [boss]", "update to [person]", "weekly team announcement"

## Steps

Execute in order:

### 1. Identify Type, Topic, and Audience
Parse the arguments. Infer audience from the topic if not stated. Read `config/team.md` to match names to roles.

### 2. Read Memory for Context
- `memory/people.md` — background on the recipient(s)
- `memory/projects.md` — context on the topic
- `memory/comms-style.md` — user's voice and audience preferences
- `memory/decisions.md` — any relevant decisions to reference

### 3. Gather Live Context (if needed)
For time-sensitive communications (outage update, escalation):
- Check Slack for latest status
- Check Gmail for any recent threads on the topic
- Use this to ensure the draft is current

### 4. Draft

**Format by type:**

**Email** — Subject line + greeting + body + sign-off. Match formality to audience.

**Slack** — Conversational, scannable. Use bold for key points. No formal greeting.

**Agenda** — Bullet list with time allocations and owner per item.

**Doc / PRD Section** — Structured markdown, appropriate section depth.

**Announcement** — Opening hook, key info, call to action. Team-friendly.

**Escalation** — Context → Impact → Ask. Urgent but not alarmist.

**Feedback** — SBI format (Situation-Behaviour-Impact) for development feedback.

### 5. Present the Draft

```
# Draft: [Type] — [Topic]
*Audience: [Name/Group]*
*Tone: [e.g. Direct / Strategic / Supportive]*

---

[The draft]

---

*Want me to:*
- *Make it shorter / longer?*
- *Change the tone?*
- *Try a different format?*
- *Add more context on [topic]?*
```

### 6. On Approval
Save to clipboard or file as requested. Never send directly.

## Tone Matrix

Read `config/team.md` for stakeholder communication styles. General rules:

| Audience | Tone | Detail |
|----------|------|--------|
| Boss / Director | Strategic, confident | High-level, risk-surfacing |
| Engineering peers | Technical, delivery-focused | Medium, metric-grounded |
| Direct reports | Clear, supportive | Specific ask, give context |
| Team (all) | Energising, direct | Short, scannable |
| External supplier | Professional | No internal detail |

## Trigger Phrases
"draft an email", "write a slack message", "comms draft", "help me write", "draft a message to [person]", "write up [topic]", "draft an announcement"
