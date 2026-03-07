---
name: stakeholder-brief
description: Prepares a strategic brief for a stakeholder (default is boss) on any topic. Synthesises memory and live sources into a polished, audience-calibrated update. Ready to use as an email, Slack message, or verbal talking points. Always presents a draft for review — never sends.
---

# Stakeholder Brief

You are preparing a strategic brief to share with a stakeholder. Gather everything relevant, write it at the right level, present for review.

## Arguments
`/stakeholder-brief [topic]` — e.g., "roadmap", "Q1 OKR status", "supplier risk", "team restructure"
`/stakeholder-brief [topic] for [person]` — e.g., "OKR narrative for [eng manager]"

## Steps

Execute in order:

### 1. Identify Topic and Audience
- Read `config/team.md` — identify the default boss (first stakeholder) and available stakeholders
- If "for [person]" specified, adjust tone and detail level accordingly

### 2. Read Memory
Read all relevant memory files:
- `memory/projects.md` — project status on the topic
- `memory/okrs.md` — OKR status
- `memory/decisions.md` — recent decisions related to the topic
- `memory/people.md` — stakeholder context
- `memory/comms-style.md` — communication preferences

### 3. Launch Stakeholder Briefer Sub-Agent
Use the Agent tool to invoke the `stakeholder-briefer` sub-agent at `agents/stakeholder-briefer.md`.

Pass it:
- The topic
- The audience (default: boss from config/team.md)
- Relevant context from memory

Wait for the formatted draft.

### 4. Present the Draft

Display the draft brief in full. Then add:

```
---
*Draft ready for your review. Want me to:*
- *Adjust the tone (more/less direct)?*
- *Add more detail on any section?*
- *Convert to email format?*
- *Convert to Slack message (shorter)?*
*Say "looks good" to save it, or tell me what to change.*
```

### 5. Save on Approval
When approved, save to `memory/briefs/[YYYY-MM-DD]-[topic-slug].md`

## Tone Rules
- For boss/director: strategic, confident, honest about risks. 1 page max. No operational noise.
- For engineering peers: more technical detail ok, delivery focus
- For external peers: collegial, transparent, co-ownership framing

## Trigger Phrases
"brief for [boss]", "update for my boss", "draft stakeholder update", "prepare an update on [topic]", "write up [topic] for [person]"
