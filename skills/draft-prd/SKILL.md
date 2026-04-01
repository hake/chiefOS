---
name: draft-prd
description: Draft a Product Requirements Document (PRD) for a new feature or initiative. Guides the user through requirements gathering and produces a structured PRD in markdown.
argument-hint: "[feature or initiative name]"
---

# Draft PRD

You are helping draft a Product Requirements Document. PRDs should be opinionated, outcome-focused, and ready to share with engineering and stakeholders.

## Non-Interactive Mode (Cowork)
When running in non-interactive mode (see `core/platform.md`):
- Skip Phase 1 conversational requirements gathering — infer all details from the provided topic argument, memory, and config
- Skip Phase 4 review iteration — produce the PRD in a single pass
- Save the PRD directly to `reports/prds/YYYY-MM-DD-[feature-slug].md`
- Requires a topic argument — if missing, output an error: "Non-interactive mode requires a feature name argument."

## Setup

Read:
- `config/profile.md` — user's name and role for the author field
- `config/domain.md` — team name, industry terminology, and key systems

## Process

### Phase 1: Requirements Gathering (Conversational)

Before writing anything, have a focused conversation to understand:

1. **What** is the feature/initiative? (Get a crisp one-liner)
2. **Why** are we building this? (Business driver, user pain point, strategic goal)
3. **Who** benefits? (End users, internal teams, supply partners?)
4. **What does success look like?** (Specific metrics and targets)
5. **What are the constraints?** (Timeline, technical limitations, dependencies)
6. **What are we NOT doing?** (Explicit scope exclusions)

Ask these questions conversationally, 2-3 at a time. Do not dump all questions at once.

If $ARGUMENTS is provided, use it as the starting point and skip asking "what is the
feature" -- instead confirm your understanding and move to "why."

### Phase 2: Research (Optional)

If relevant, check:
- Notes app for any existing notes on this topic (read `config/integrations.md` for the `notes_app` value, then use `core/notes-integration.md` for the correct search tool; skip if `notes_app` is `none`)
- Recent emails for context on this initiative (use gmail search)
- Any related docs in Google Drive

### Phase 3: Draft the PRD

Use this template structure. Write in a professional, direct tone. Be opinionated —
recommend approaches, don't just list options.

---

# PRD: [Feature Name]

**Author**: [User name from config/profile.md]
**Date**: [Today's date]
**Status**: Draft
**Team**: [Team from config/domain.md]

---

## 1. Overview
[2-3 sentence executive summary. What are we building and why it matters.]

## 2. Problem Statement
[What problem exists today? Who experiences it? What's the cost of inaction?]

## 3. Goals & Success Metrics

| Goal | Metric | Target | Timeline |
|------|--------|--------|----------|
| [Goal 1] | [Metric] | [Target] | [When] |

## 4. User Stories
- As a [persona], I want to [action] so that [outcome]

## 5. Proposed Solution

### 5.1 High-Level Approach
[Describe the recommended solution at a conceptual level]

### 5.2 Key Features

**Must Have**:
- ...

**Should Have**:
- ...

**Could Have**:
- ...

**Won't Have (this version)**:
- ...

### 5.3 Technical Considerations
[Any known technical constraints, integration points, data requirements]

## 6. Dependencies
[External teams, systems, or partners this depends on]

## 7. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| [Risk 1] | H/M/L | H/M/L | [Plan] |

## 8. Timeline & Milestones
[High-level phases with estimated dates or relative sizing]

## 9. Open Questions
[Things still to be resolved — assign owners where possible]

---

### Phase 4: Review and Iterate

After generating the draft:
1. Present for review
2. Ask "What would you change, add, or remove?"
3. Iterate until satisfied
4. Offer to save it:
   - As a note in the configured notes app (use `core/notes-integration.md` for the correct create tool; skip if `notes_app` is `none`)
   - As a Google Doc
   - Output as raw markdown for copy-paste

### Writing Guidelines
- Be specific over generic. "Increase booking conversion by 2pp" over "improve conversion"
- Include domain context from `config/domain.md` where relevant
- Reference industry terminology naturally
- Keep sections concise — this should be readable in 10 minutes
- Surface trade-offs explicitly, then recommend a path
