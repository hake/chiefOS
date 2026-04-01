---
name: delegate
description: Smart delegation engine. Analyses team capacity, recommends who to assign work to, drafts a delegation message in the right tone, and tracks the item in memory. Use when you receive a task to hand off, want to assign work to your team, or need to rebalance workload.
argument-hint: "[task description] [optional: to person]"
---

# Delegate

You are helping the user delegate a task to the right person with the right context. Analyse the team, recommend a person (or validate the user's choice), draft the message, and track it.

## Non-Interactive Mode (Cowork)
When running in non-interactive mode (see `core/platform.md`):
- Requires a task description argument — if missing, output: "Usage: /delegate [task description] or /delegate [task] to [person]"
- If no person specified, auto-select the top recommendation from the sub-agent analysis
- Draft the delegation message and save directly — skip revision offers
- Save output to `reports/delegations/YYYY-MM-DD-[task-slug].md`
- Update `memory/people.md` with the delegated action item without asking

## Setup

Before analysing, read:
- `config/team.md` — direct reports (names, areas, "what good looks like") and stakeholders
- `config/profile.md` — user's name and role
- `config/integrations.md` — which MCP tools are configured
- `memory/people.md` — current context per person, open actions, recent state
- `memory/projects.md` — active initiatives and ownership

## Steps

Execute in order:

### 1. Parse the Request

From `$ARGUMENTS`, extract:
- **Task description**: What needs to be done
- **Target person** (if specified): Look for "to [name]" pattern
- **Urgency cues**: Keywords like "ASAP", "by Friday", "urgent", "when you can"
- **Context cues**: Any project or topic references

If no arguments provided (interactive mode only): ask "What task do you want to delegate?"

### 2. Launch Delegate Analyzer Sub-Agent

Use the Agent tool to invoke the `delegate-analyzer` sub-agent at `agents/delegate-analyzer.md`.

Provide it with:
- The task description
- The target person (if specified) or "recommend"
- The list of direct reports from config/team.md
- Current open actions per person from memory/people.md

Wait for its JSON output.

### 3. Present the Recommendation

If no person was specified by the user, present the recommendation:

```
# Delegation Analysis — [Task summary]

## Recommended: [Person Name]
**Why**: [Reason — area match, capacity, growth opportunity]

**Their current load**:
- [X] open Jira tickets ([Y] in progress, [Z] blocked)
- [X] meetings today/this week
- [X] open actions from you

**Alternatives**:
| Person | Fit | Load | Trade-off |
|--------|-----|------|-----------|
| [Alt 1] | [area match] | [capacity signal] | [why not #1] |
| [Alt 2] | [area match] | [capacity signal] | [why not #1] |

*Agree with [Name], or should I assign to someone else?*
```

If a person WAS specified, validate:
- Show their current load
- Flag if overloaded: "Heads up: [Person] has [X] open items. Still want to assign this to them?"
- If load is fine: proceed directly to drafting

### 4. Draft the Delegation Message

Once the person is confirmed (or auto-selected in Cowork mode), draft the message.

**Detect delivery channel**: If Slack is configured, default to Slack format. If only email, use email format. User can override.

**Slack format**:
```
Hey [Person] — I'd like you to take on [task].

**What**: [Clear description of the task — 2-3 sentences]
**Why it matters**: [Business context — why this is important]
**Success looks like**: [Specific, measurable outcome]
**Timeline**: [Deadline or "no hard deadline, but aim for [timeframe]"]
**Dependencies**: [Anything they need from you or others to get started]

Let me know if you have questions or need anything unblocked.
```

**Email format**:
```
Subject: [Task] — action for you

Hi [Person],

I'd like you to take ownership of [task].

Context: [Why this matters — 2-3 sentences]

What success looks like: [Specific outcome]

Timeline: [Deadline or flexible timeframe]

Dependencies: [What they need from you or others]

Let me know if you have any questions or need anything unblocked.

Best,
[User name]
```

**Tone matching** (from `core/audience-matching.md` and `config/team.md`):
- **Direct reports**: Clear, supportive, specific ask with context
- **Peers / cross-functional**: Collaborative framing, co-ownership language
- **External**: Professional, scoped, no internal detail

Present the draft:
```
# Draft: Delegation to [Person] — [Task]
*Channel: [Slack / Email]*
*Tone: [Supportive / Collaborative / Professional]*

---

[The message]

---

*Want me to:*
- *Change the tone or format?*
- *Add more context?*
- *Switch to [email/Slack]?*
```

### 5. Update Memory

After the user approves (or immediately in Cowork mode):

**Add to `memory/people.md`** under the person's entry:
```markdown
- **Delegated**: [Task summary] (as of YYYY-MM-DD)
  - Source: User delegation via /delegate
  - Deadline: [date or "flexible"]
  - Status: Open
```

**Add to `memory/projects.md`** if the task relates to a known project:
```markdown
- **[Task]**: Delegated to [Person] (as of YYYY-MM-DD) — [deadline]
```

Propose the memory updates: "Shall I track this delegation in memory? I'll add it to [Person]'s open actions so it surfaces in future briefings and 1-2-1 preps."

### 6. Archive Report

1. Write the full delegation record to `reports/delegations/YYYY-MM-DD-[task-slug].md`
2. Include: task description, assigned person, rationale, capacity analysis, draft message, deadline
3. If a report already exists for the same task today, append with a timestamp
4. Confirm: "Report saved to `reports/delegations/YYYY-MM-DD-[task-slug].md`"

## Delegation Tracking (Proactive)

Once tracked in `memory/people.md`, existing proactive behaviors handle follow-up:
- **Overdue action items** (>14 days): Raised at next 1-2-1 via `/prep-1-2-1`
- **Briefing integration**: `/briefing` reads `memory/people.md` and surfaces open actions >14 days old
- **Team pulse**: `/team-pulse` checks open actions per person

## Trigger Phrases
"delegate", "assign this to", "hand off", "give this to [person]", "who should handle this", "delegate to my team", "pass this to", "task assignment"
