---
name: learn
description: Teach chiefOS about something new. Give it a URL to crawl, a person to research, a topic to deep-dive, or just say "learn" to trigger a context refresh from all connected tools. Makes chiefOS smarter on demand.
argument-hint: "[URL | person name | topic | 'refresh']"
---

# Learn

You are helping chiefOS learn something new. This skill makes the system smarter on demand — beyond the passive learning that happens in every conversation.

## Modes

Detect the mode from `$ARGUMENTS`:

- **URL** (starts with `http` or contains `.com`, `.io`, `.org`, etc.) → Website Research mode
- **Person name** (matches a name pattern, or found in `memory/people.md`) → Person Research mode
- **"refresh"** or **"rescan"** → Full Context Refresh mode
- **Any other text** → Topic Deep-Dive mode
- **No arguments** → ask "What should I learn about? You can give me a URL, a person's name, a topic, or say 'refresh' to rescan all your tools."

---

## Mode 1: Website Research

When given a URL, crawl it and extract useful context.

### Process

1. **Crawl the URL** using WebFetch — extract the main content
2. **Follow key links** on the page (about, products, team, blog) — max 5 additional pages
3. **Extract and categorise**:
   - **Company info**: name, industry, size, markets, mission
   - **Products/services**: names, descriptions, capabilities
   - **Terminology**: domain-specific words and acronyms
   - **Technology**: tech stack mentions, platforms, integrations
   - **People**: leadership team, department heads (if visible)
   - **Partners/suppliers**: mentioned companies, integration partners
   - **Recent news**: product launches, funding, strategy shifts

4. **Cross-reference with existing memory**:
   - Is this company already in `memory/suppliers.md`?
   - Does this relate to any active project in `memory/projects.md`?
   - Are any people mentioned already in `memory/people.md`?

5. **Present findings**:
```
Here's what I learned from [URL]:

**Company**: [name] — [one-liner description]
**Industry**: [industry]
**Key products**: [list]
**Terminology**: [relevant terms]
**Technology**: [tech mentions]
**Relevance to you**: [how this connects to existing context]

Where should I save this?
- Update config/domain.md (if it's your company)
- Update memory/suppliers.md (if it's a supplier/partner)
- Update memory/tech-landscape.md (if it's a tech/tool)
- Update memory/projects.md (if it relates to a project)
- Don't save (just for reference)
```

6. **Save** based on user's choice. Always date-stamp entries.

---

## Mode 2: Person Research

When given a person's name, research them across all connected tools.

### Process

1. **Check existing memory** — read `memory/people.md` for existing context
2. **Search all connected sources in parallel**:
   - **Gmail**: Search for emails from/to this person (last 90 days). Extract: email address, communication frequency, topics, tone, their role in threads
   - **Slack**: Search for messages from/mentioning this person (last 30 days). Extract: channels they're active in, topics, Slack handle
   - **Calendar**: Search for meetings with this person (last 30 days + next 2 weeks). Extract: meeting cadence, shared meetings, other attendees
   - **Jira**: Search for tickets assigned to or created by this person. Extract: their project areas, current workload, any blocked items
   - **Confluence**: Search for pages authored by this person. Extract: their documentation areas, recent contributions
   - **Notes**: Search for mentions of this person. Extract: any existing notes or todos

3. **Synthesise a profile**:
```
Here's what I know about [Name]:

**Role**: [extracted or inferred]
**Email**: [found]
**Slack**: [found]
**Relationship to you**: [direct report / stakeholder / peer / external]

**Communication style**: [inferred from message tone, length, formality]
**Active topics** (last 30 days): [list]
**Meeting cadence**: [how often you meet]
**Current work**: [from Jira/Slack]
**Recent signals**: [anything notable — blockers, wins, concerns]

**Open items between you**:
- [Any pending actions, unanswered emails, upcoming meetings]

Should I save this to memory/people.md?
```

4. **Save** if confirmed. If the person is new, also ask: "Should I add them to config/team.md as a direct report or stakeholder?"

---

## Mode 3: Topic Deep-Dive

When given a topic (e.g. "learn about our mapping system", "learn about OKRs"), research it across all sources.

### Process

1. **Check existing memory** — search all memory files for the topic
2. **Search all connected sources in parallel**:
   - **Gmail**: topic keywords in last 90 days
   - **Slack**: topic keywords in last 30 days
   - **Jira**: topic as search query
   - **Confluence**: topic as search query
   - **Notes**: topic search
   - **Web** (if applicable): search for public information

3. **Synthesise findings**:
```
Here's what I found about [topic]:

**What it is**: [synthesis from all sources]
**Key people involved**: [who discusses this most]
**Current state**: [active/completed/stalled]
**Recent activity** (last 30 days):
- [Source]: [key finding]
- [Source]: [key finding]

**Decisions made**: [any decisions found]
**Open questions**: [unresolved threads]
**Related to**: [connected projects, OKRs, or initiatives in memory]

Should I save this to memory? I'd update:
- memory/projects.md — [what I'd add]
- memory/decisions.md — [what I'd add]
```

4. **Save** based on user confirmation.

---

## Mode 4: Full Context Refresh

When the user says "refresh" or "rescan", re-scan all connected tools to update memory.

### Process

1. Read `config/integrations.md` for connected tools
2. Read all existing memory files to know current state
3. **Scan all tools in parallel** (same as setup Phase 5):
   - Gmail: last 7 days, focus on new contacts, topics, decisions
   - Calendar: next 2 weeks + last week
   - Slack: last 7 days, mentions, DMs, key channels
   - Jira: current sprint, blocked tickets, recently updated
   - Notes (if configured in `config/integrations.md`): all open todos — use `core/notes-integration.md` for tool mapping
   - Confluence: recently modified pages

4. **Compare with existing memory** — identify:
   - **New**: things not yet in memory
   - **Updated**: things that have changed since last memory entry
   - **Stale**: memory entries contradicted by new information
   - **Confirmed**: memory entries validated by current signals

5. **Present delta only**:
```
Context refresh complete. Here's what changed:

**New** (not in memory yet):
- [Person/project/topic] — found in [source]

**Updated** (memory needs refreshing):
- [Entry] — was "[old]", now "[new]" — [source]

**Stale** (memory may be outdated):
- [Entry] — last updated [date], no recent signals

**Memory health**: [X] files current, [Y] need attention

Should I apply these updates?
```

6. **Apply** on confirmation. Date-stamp all changes.

---

## General Rules

- **Always ask before writing**: Never silently update memory. Present findings and get confirmation.
- **Date-stamp everything**: Every entry gets `(as of YYYY-MM-DD)`.
- **Don't duplicate**: If information already exists in memory, update the existing entry — don't create a new one.
- **Cross-reference**: After learning something new, check if it connects to existing memory. Surface connections unprompted.
- **Respect the user's time**: Present findings concisely. Don't dump raw data — synthesise.
- **Source attribution**: Always note where information came from (email, Slack, Jira, web, etc.).
