---
name: risk-radar
description: Risk and blocker synthesis across all active projects. Pulls from Jira blocked tickets, Slack blocker language, and project/OKR memory to produce a prioritised risk register. Run before sprint planning, quarterly reviews, or any time you want full visibility on what might derail delivery.
---

# Risk Radar

You are generating a risk register across all active projects. Surface blockers early, before they become fires.

## Steps

Execute in order:

### 1. Read Project and OKR Memory
Read `memory/projects.md` for current initiative status and `memory/okrs.md` for at-risk OKRs. These are your baseline.

### 2. Jira Scan (skip if not configured in config/integrations.md)
Search Jira for:
- Tickets with status "Blocked" across configured project keys
- Tickets overdue (past due date, not done)
- Epics with no progress in the past 14 days
- P0 or P1 open tickets

### 3. Slack Scan (past 7 days)
Search for:
- "blocked", "blocker", "stuck", "waiting on", "no response", "can't proceed"
- "P0", "P1", "urgent", "critical"
- Technical issues: "API down", "integration failing", "error rate"

Group by source (which squad/PM area) to link back to projects.

### 4. Cross-Reference Memory
For each risk found, check if it's already tracked in `memory/projects.md`. If it is, note if it's getting worse. If it's new, flag it clearly.

### 5. Classify and Present

Risk severity:
- 🔴 **Critical**: Blocking delivery of a committed initiative or OKR; needs action today
- 🟡 **High**: Will become critical if not addressed this week
- 🟢 **Low**: Known risk, tracked, has mitigation in place

```
# Risk Radar — [Today's date]

## Summary
🔴 [X] Critical — 🟡 [Y] High — 🟢 [Z] Low

---

## 🔴 Critical Risks

### [Risk Title]
- **Area**: [PM / Squad]
- **What**: [Specific description of the risk or blocker]
- **Impact**: [What delivery or OKR is affected]
- **Who's involved**: [Names]
- **Source**: [Jira ticket / Slack thread / both]
- **Action needed**: [Specific next step — who should do what]

---

## 🟡 High Risks

[Same format]

---

## 🟢 Low Risks (tracked)

[Bullet list — "Area: Brief description (Owner, mitigation in place)"]

---

## Risks New Since Last Check
[Anything that wasn't in memory before this scan]

## Risks That Have Resolved
[Anything from memory that now appears clear]
```

### 6. Memory Update Proposal
Offer to update `memory/projects.md` with any new risks found.

### 7. Archive Report

After presenting, save a copy for future reference:

1. Write the full formatted risk radar to `reports/risk-radar/YYYY-MM-DD.md` (using today's date)
2. If a report already exists for today, overwrite it with the latest version
3. Confirm: "Report saved to `reports/risk-radar/YYYY-MM-DD.md`"

## Trigger Phrases
"risk radar", "risk check", "what's blocked", "blockers", "risk register", "what might derail us"
