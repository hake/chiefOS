---
name: supplier-watch
description: Supplier and partner health monitoring. Scans Slack, Gmail, and Jira for supplier degradation signals, new issues, and opportunities. Updates supplier memory and presents a health dashboard. Run weekly or whenever you want a quick supplier situation check.
---

# Supplier Watch

You are generating a supplier health dashboard. Catch degradation early, before it becomes a failure.

## Steps

Execute in order:

### 1. Read Supplier Memory
Read `memory/suppliers.md` to know the current baseline and which suppliers to monitor.

### 2. Launch Supplier Watcher Sub-Agent
Use the Agent tool to invoke the `supplier-watcher` sub-agent at `agents/supplier-watcher.md`.

Wait for its JSON output and confirmation that `memory/suppliers.md` has been updated.

### 3. Present the Dashboard

Build the table dynamically from the sub-agent's response. Use owner names from `config/team.md`:

```
# Supplier Health Dashboard — [Date]

## Overall: [X] Healthy / [Y] Watch / [Z] Critical

| Supplier | Type | Owner | Status | Delta | Issue |
|----------|------|-------|--------|-------|-------|
| [Name] | [Type] | [Owner] | 🟢/🟡/🔴 | →/↑/↓ | [Brief or None] |

---

## 🔴 Critical Issues

### [Supplier Name]
- **Issue**: [Specific description]
- **Since**: [Date first noticed]
- **Impact**: [What's affected and how]
- **Owner**: [Who should address this]
- **Action needed**: [Specific next step]

---

## 🟡 Watch Items

[Same format but less urgent]

---

## New Since Last Check
[Suppliers that changed status]

## Resolved This Week
[Issues that cleared]

## Trending Concerns
[Cross-supplier patterns]
```

### 4. Action Prompts
For any Critical issue, offer:
- "Shall I draft a message to [owner] about this?"
- "Shall I add this to the risk radar?"

### 5. Archive Report

After presenting, save a copy for future reference:

1. Write the full formatted supplier dashboard to `reports/supplier-watch/YYYY-MM-DD.md` (using today's date)
2. If a report already exists for today, overwrite it with the latest version
3. Confirm: "Report saved to `reports/supplier-watch/YYYY-MM-DD.md`"

## Trigger Phrases
"supplier watch", "supplier health", "partner status", "any supplier issues", "how are the suppliers"
