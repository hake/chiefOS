---
name: okr-narrative
description: Generates a written OKR progress narrative for stakeholder consumption. Takes the raw status data and wraps it in a coherent story suitable for monthly business reviews or board-level summaries. Different from /okr-update which gives a dashboard — this gives a document.
---

# OKR Narrative

You are generating a written OKR progress narrative. This is a document, not a dashboard — it tells a story about where we are and why.

## Non-Interactive Mode (Cowork)
When running in non-interactive mode (see `core/platform.md`):
- Default audience to leadership — write at executive level
- If memory/okrs.md is stale (>7 days old), proceed with available data and note the staleness in the narrative — do not offer to run /okr-update first
- Skip Step 3 review check ("Any adjustments?") — produce the narrative in a single pass
- Save directly to reports and memory without asking for approval

## Steps

Execute in order:

### 1. Gather Data
Read:
- `memory/okrs.md` — current status per KR
- `memory/decisions.md` — any relevant decisions (pivots, scope changes)
- `memory/projects.md` — project-level context
- `config/profile.md` — user's name and role for attribution
- `config/domain.md` — team/department name for the header

If `memory/okrs.md` is more than 7 days old, offer to run `/okr-update` first.

### 2. Draft the Narrative

Structure:

```markdown
# Q[X] [YEAR] OKR Progress — [Team/Department from config]
*[Date] — Prepared by [User Name from config/profile.md]*

## Executive Summary
[2-3 sentences: overall trajectory, headline achievement, headline risk]

## What We Set Out to Do
[Brief restatement of the objectives — what we committed to at the start of the quarter and why]

## Progress by Objective

### Objective 1: [Title]
[One paragraph: what we've achieved, what the numbers show, what's driven performance]

**Key Results**:
- [KR title]: [Target] → currently [Current] — [🟢 on track / 🟡 at risk / 🔴 off track]
  *[One sentence of context — what's driving this number]*

[Repeat per KR]

### [Additional objectives...]

## Where We're Behind and Why
[Honest paragraph about any at-risk or off-track KRs. What's the root cause? What are we doing about it?]

## Pivots and Decisions
[Any scope changes, re-prioritisations, or strategic pivots made during the quarter — from decisions.md]

## Outlook for Quarter End
[Assessment: will we hit our objectives? What needs to happen in the remaining weeks?]

## Asks / Watch Items
[Anything leadership needs to decide, unblock, or be aware of]
```

### 3. Review Check
After drafting, ask: "Any adjustments before I save this? I can change the tone, add more detail on any section, or trim it further."

### 4. Save
Once approved, save to `memory/okr-narrative-[YYYY-MM].md`

### 5. Archive Report

Also save a copy to the reports archive:

1. Write the narrative to `reports/okr-narratives/YYYY-QN.md` (using quarter, e.g. `2026-Q1.md`)
2. If a report already exists for this quarter, overwrite it with the latest version
3. Confirm: "Report also saved to `reports/okr-narratives/YYYY-QN.md`"

## Writing Style Rules
- Tell a story — not a list of metrics
- Be honest about what's behind and why — no spin
- Keep it to 1 page if possible, 2 pages maximum
- Connect delays to causes, not just symptoms
- Use the user's voice — direct, no corporate fluff (reference `memory/comms-style.md`)

## Trigger Phrases
"okr narrative", "progress story", "write up the OKRs", "monthly OKR summary", "business review prep"
