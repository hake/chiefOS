---
name: onboarding-brief
description: Generates a context document for a new team member or stakeholder. Covers who's who, product areas, active initiatives, OKR status, and the 3 most important things to know first. Use when onboarding a new direct report, a new stakeholder, or anyone who needs to get up to speed fast.
argument-hint: "[person's name or role]"
---

# Onboarding Brief

You are generating a context document for someone new joining the team. The goal: they should be able to read this in 10 minutes and walk into their first week without asking basic questions.

## Setup

Read:
- `config/profile.md` — user's name, role, company
- `config/team.md` — full team structure, direct reports, stakeholders
- `config/domain.md` — product areas, key systems, terminology
- `config/integrations.md` — tools and Jira project keys

## Arguments
`/onboarding-brief [person]` — e.g. "new PM for [area]", "new stakeholder from Finance"

## Steps

Execute in order:

### 1. Identify the person and their role
Parse the argument to understand:
- **Who** is this person (name if known, or role)
- **What area** will they work in
- **What level** are they joining at (PM, senior PM, director, external stakeholder)

If the area is unclear, default to covering the full domain.

### 2. Read all memory files
Read in full:
- `memory/people.md` — team, stakeholders, key contacts
- `memory/projects.md` — active initiatives per person
- `memory/okrs.md` — current OKR status
- `memory/tech-landscape.md` — systems and integrations
- `memory/suppliers.md` — supplier landscape
- `memory/recurring.md` — meetings and cadences
- `memory/decisions.md` — recent key decisions

### 3. Tailor scope to the person's role

**If joining as a team member in a specific area**:
- Deep section on their specific area: team, projects, current initiatives, key systems
- Lighter coverage of adjacent areas

**If joining as a cross-functional stakeholder**:
- Broader overview of all product areas
- Emphasis on how the team connects to their function
- Skip deep technical detail

**If joining as a new direct report**:
- Full team map
- How the user runs the team (cadences, communication style, OKR process)
- What "good" looks like in this team

### 4. Generate the onboarding brief

Present in this format (populate names and details from config files and memory):

```markdown
# Onboarding Brief — [Person / Role]
*Prepared by [User Name], [User Role] — [Company]*
*[Date]*

---

## Welcome to [Team/Department]

[2-3 sentence orientation: what this team does, why it matters, and where it sits in the org]

---

## The Team

| Person | Role | Area | What Good Looks Like |
|--------|------|------|---------------------|
[Populate from config/team.md — user first, then all direct reports]

**Key partners:**
[Stakeholders from config/team.md with role descriptions]

---

## The Product Landscape

### What We Own
[From config/domain.md — brief description of all product areas]

### How It All Connects
[Simple description of how the pieces fit together]

### Key Systems
[From config/domain.md or memory/tech-landscape.md: 3-5 most important systems]

### Key Terminology
[From config/domain.md: important domain terms]

---

## Active Initiatives

[Per area — pull from memory/projects.md]

| Area | Initiative | Status | Owner |
|------|-----------|--------|-------|
| [Area] | [Initiative name — one sentence] | 🟢/🟡/🔴 | [Person] |

---

## Current OKRs

[Pull from memory/okrs.md. If not yet populated, note: "Run /okr-update to see live OKR status."]

---

## How We Work

### Cadences
[From memory/recurring.md — weekly 1-2-1s, OKR cycles, reviews]

### Tools
[From config/integrations.md — Jira projects, Confluence spaces, Slack channels, other tools]

### Communication Style
[From memory/comms-style.md — how the user communicates, what they value]

---

## The 3 Things to Know First

1. **[Most important context item]** — [2-3 sentences on why this matters for day 1]
2. **[Second most important]** — [2-3 sentences]
3. **[Third most important]** — [2-3 sentences]

*These are the things that, if you don't know them, will confuse you in your first week.*

---

## Recent Key Decisions

[Pull last 3-5 entries from memory/decisions.md]

---

## First Week Suggested Priorities

1. Meet each team member for a 30-min intro
2. Read the OKR page or run `/okr-update`
3. Join key Slack channels
4. Review the most relevant project for their area
5. Shadow one planning session

---

*Questions? Reach out directly or book time on the calendar.*
```

### 5. Offer follow-up actions

After presenting the brief, offer:
- "Want me to save this as a note so you can share it?"
- "Shall I draft a welcome Slack message to send when they join?"
- "Want me to add a 1-2-1 agenda for your first meeting with them?"

## Trigger Phrases
"onboarding brief", "new joiner doc", "context doc for", "onboard", "help [name] get up to speed", "new team member joining", "welcome doc"
