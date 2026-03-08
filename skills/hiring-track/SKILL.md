---
name: hiring-track
description: Recruitment pipeline tracker. Searches Gmail, Slack, and notes to build a current view of open roles, candidates in pipeline, next steps, and anything waiting on the user. Run before hiring syncs with HR or before weekly team meetings where headcount is on the agenda.
---

# Hiring Track

You are building a current picture of the hiring pipeline. Every open role, every candidate, and everything waiting on you.

## Steps

Execute in order:

### 1. Gmail Scan (past 30 days)
Search for:
- Emails from recruitment agencies or job boards (LinkedIn, Indeed, Greenhouse, etc.)
- Emails with subject containing: "application", "candidate", "interview", "offer", "headcount"
- Emails from HR team
- CV/resume attachments
- Interview scheduling emails

For each thread found, extract: role, candidate name (if visible), stage, what's next, what's waiting on the user.

### 2. Slack Scan (past 30 days)
Search for:
- "hiring", "headcount", "open role", "interview", "candidate", "JD", "job description"
- Any hiring-related channel (e.g. #hiring, #recruiting, #hr)
- DMs from HR or from anyone discussing candidates

### 3. Notes Scan
Read `config/integrations.md` for the `notes_app` value. If `none` or not set, skip this step. Otherwise, use the tool mapping in `core/notes-integration.md` to search for:
- Any notes about open roles or candidate pipeline
- Interview feedback notes
- Hiring criteria or JD drafts

### 4. Present the Pipeline

```
# Hiring Pipeline — [Date]

## Open Roles ([count])

| Role | Status | Candidates in Pipe | Urgent? |
|------|--------|-------------------|---------|
| [Role title] | [Active/Paused/Draft] | [Count] | [Yes/No] |

---

## Candidates — Active Pipeline

### [Role Title]
| Candidate | Stage | Last Action | Next Step | Waiting On |
|-----------|-------|-------------|-----------|------------|
| [Name] | [Stage] | [Date + what] | [What's next] | [User / HR / Hiring manager] |

---

## Waiting on You ([count])
[List of specific actions you need to take — prioritised]
1. [Action 1 — candidate, role, what's needed, by when]
2. [Action 2]

---

## Recently Closed Roles
[Any roles filled or cancelled in the past 30 days]

## Notes
[Anything that didn't fit above — patterns, concerns, etc.]
```

### 5. Offer to Draft
If any candidate is at offer stage, offer: "Shall I draft the offer communication or prep talking points for the offer call?"

## Trigger Phrases
"hiring update", "recruitment status", "who's in the pipeline", "hiring pipeline", "open roles", "where are we with hiring"
