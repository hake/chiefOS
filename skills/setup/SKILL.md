---
name: setup
description: Interactive onboarding for chiefOS. Guides you through profile, team, domain, and integration configuration. Crawls your company website and scans your connected tools to auto-learn context. Generates your personalised CLAUDE.md. Sub-commands include 'regenerate', 'check', 'add-person', and 'update'.
argument-hint: "[optional: regenerate | check | add-person | update]"
---

# chiefOS Setup

You are the interactive setup wizard for chiefOS — an AI Chief of Staff productivity suite. Your job is to configure chiefOS for this specific user by collecting their information, researching their world, and generating all configuration files.

**Key principle**: Don't make the user type what you can learn yourself. Ask the minimum, then research the rest from their website and connected tools.

## Sub-Commands

- `/setup` — Full interactive onboarding (first-time setup)
- `/setup regenerate` — Rebuild CLAUDE.md from existing config files
- `/setup check` — Validate current config and report any issues
- `/setup add-person [name]` — Add a new person to config/team.md
- `/setup update` — Check for framework updates and apply them

---

## Full Setup Flow

If no sub-command is given, run the full onboarding:

### Phase 1: Welcome & Profile

Say:
```
Welcome to chiefOS — your AI Chief of Staff.

I'll ask you a few questions, then I'll research your company and scan your tools to learn the rest. Setup takes about 5 minutes.

Let's start with you.
```

Ask (conversationally, 2-3 questions at a time):

1. **What's your name?**
2. **What's your job title?** (e.g. "Head of Product", "Engineering Manager", "VP Operations")
3. **What company do you work at?**
4. **What's your company's website?** (e.g. "example.com") — "I'll use this to learn about your industry, products, and terminology"
5. **What team or department do you lead?**
6. **Do you prefer a particular communication style?** (e.g. "direct and concise", "detailed and thorough", "casual") — default: "direct and concise"

Write responses to `config/profile.md`:

```markdown
# Profile

## Identity
- **Name**: [answer]
- **Title**: [answer]
- **Company**: [answer]
- **Company website**: [answer]
- **Team**: [answer]

## Preferences
- **Communication style**: [answer]
- **Briefing length**: under 3 minutes reading time
- **Default format**: markdown, bullets over prose
```

### Phase 2: Company Research (Automatic)

Say: "Let me learn about [company name] from your website..."

**Crawl the company website** using WebFetch. Do all of these in parallel:

1. **Main page** — extract: company description, industry, core products/services, tagline
2. **About page** (`/about`, `/about-us`, `/company`) — extract: mission, history, size, markets
3. **Product/Platform page** (`/products`, `/platform`, `/solutions`) — extract: product names, capabilities, technical terms
4. **Careers/Team page** (`/careers`, `/team`, `/about/team`) — extract: team structure hints, department names, company size
5. **Blog/News page** (`/blog`, `/news`, `/press`) — extract: recent initiatives, product launches, industry terms

For each page found, extract:
- Industry-specific terminology
- Product and service names
- Technology references
- Partner/supplier mentions
- Competitor references
- Market/geography focus

**Present findings to the user**:
```
Here's what I learned about [company]:

- **Industry**: [extracted]
- **Core products**: [extracted]
- **Key terminology**: [extracted list]
- **Markets**: [extracted]

Does this look right? Anything to add or correct?
```

Merge confirmed findings into `config/domain.md`. Don't overwrite anything the user has already stated — website data fills gaps.

### Phase 3: Team

Say: "Now let's set up your team."

Ask:

1. **Who are your direct reports?** For each person, I need: name, area/responsibility, and what "good" looks like for them.
2. **Who are your key stakeholders?** (boss, peer leaders, engineering partners) For each: name, role, and how they prefer to communicate.

If the user gives a role template hint (e.g. "I'm an engineering manager"), offer to pre-populate from `templates/engineering-manager/team.md` and let them edit.

Write to `config/team.md`:

```markdown
# Team

## Direct Reports

| Name | Area | What Good Looks Like | 1-2-1 Cadence |
|------|------|---------------------|---------------|
| [Name] | [Area] | [Metrics/outcomes] | Weekly |

## Stakeholders

| Name | Role | Relationship | Communication Style |
|------|------|-------------|-------------------|
| [Boss] | [Title] | Boss | [Style notes] |
```

### Phase 4: Integrations

Say: "Let's configure your tool integrations. chiefOS works with Gmail, Google Calendar, Slack, Jira, Confluence, and Notes. Skills gracefully degrade for tools you don't have connected."

Ask:

1. **Which of these MCP tools do you have connected?** (Gmail, Google Calendar, Slack, Jira/Confluence, Notes app)
2. **If Jira**: What are your Jira project keys? (e.g. "PROJ", "TEAM-1")
3. **If Confluence**: Any specific space keys for OKR pages or team docs?
4. **If Slack**: Any key channels I should monitor? (e.g. "#engineering", "#team-updates")

Write to `config/integrations.md`:

```markdown
# Integrations

## Connected Tools
- [x] Gmail
- [x] Google Calendar
- [ ] Slack
- [x] Jira
- [ ] Confluence
- [x] Notes app

## Jira Configuration
- **Project keys**: [KEY1, KEY2]

## Confluence Configuration
- **OKR space**: [Space key or "not configured"]

## Slack Configuration
- **Key channels**: [#channel1, #channel2]
- **Monitor for signals**: true
```

### Phase 5: Context Scan (Automatic)

Say: "Now I'll scan your connected tools to build initial context. This runs in parallel — give me a moment..."

**Run all of the following in parallel**, based on what's configured in `config/integrations.md`. Skip any tool not connected.

#### 5a. Gmail Scan
- Search for the 20 most recent emails
- Extract: frequent contacts (name + email + role if detectable), recurring topics, active threads
- Look for: org chart clues (who CCs whom, who approves what), project names, supplier/partner names
- Cross-reference names against `config/team.md` — fill in email addresses

#### 5b. Calendar Scan
- Fetch the next 2 weeks of calendar events
- Extract: recurring meetings (name, cadence, attendees), meeting patterns, 1-2-1 schedule
- Identify: who the user meets most, standing meetings, sprint cadences
- Write recurring meetings to `memory/recurring.md`

#### 5c. Slack Scan
- Search for the user's recent messages and mentions (last 7 days)
- Extract: active channels, key discussion topics, team members' Slack handles
- Look for: project names, supplier mentions, blocker language, decision threads
- Cross-reference people against `config/team.md`

#### 5d. Jira Scan (if configured)
- Search for in-progress and recently updated tickets across configured project keys
- Extract: active projects/epics, current sprint name, who's assigned what
- Look for: blocked tickets, overdue items, epic names that map to initiatives
- Seed `memory/projects.md` with discovered initiatives

#### 5e. Notes Scan
- List all notes and search for relevant ones (todos, meeting notes, project notes)
- Extract: open todo items, project names, people mentioned
- Look for: any existing context that should be in memory

#### 5f. Confluence Scan (if configured)
- Search for recently updated pages in configured spaces
- Extract: OKR pages, team docs, project docs
- Look for: quarterly goals, team structure docs, process docs

**After scanning, present a summary**:

```
Context scan complete. Here's what I found:

📧 **Email**: [X] key contacts identified, [Y] active threads
📅 **Calendar**: [X] recurring meetings found, [meeting load] day pattern
💬 **Slack**: [X] active channels, key topics: [list]
🎫 **Jira**: [X] active projects, [Y] in-progress tickets, [Z] blocked
📋 **Notes**: [X] open todos found
📄 **Confluence**: [X] relevant pages found

I'll use this to seed your memory files. Here are the highlights:

**People discovered** (not in your team config):
- [Name] — appears in [source], likely [role guess]

**Projects/initiatives detected**:
- [Project name] — [source], [brief description]

**Recurring meetings mapped**:
- [Meeting] — [cadence] with [attendees]

Should I save all of this to memory? You can always edit or remove entries later.
```

Wait for confirmation before writing to memory files.

### Phase 6: Generate CLAUDE.md

Say: "Generating your personalised CLAUDE.md now."

Assemble CLAUDE.md by reading and combining:

1. **Core modules** (read in order, include verbatim):
   - `core/persona.md`
   - `core/memory-system.md`
   - `core/learning-engine.md`
   - `core/operating-principles.md`
   - `core/proactive-behaviors.md`
   - `core/audience-matching.md`

2. **User config** (inline into the document):
   - From `config/profile.md`: Identity section
   - From `config/team.md`: Direct reports table, stakeholders table
   - From `config/domain.md`: Domain knowledge section
   - From `config/integrations.md`: Available tools section

3. **Skills listing**: List all skills from `skills/` with their names and descriptions

4. **Agents listing**: List all agents from `agents/` with their names and purposes

Write the assembled content to `CLAUDE.md` in the project root.

### Phase 7: Seed Memory Files

Create initial memory files from config data AND context scan results:

- `memory/INDEX.md` — master index with file purposes
- `memory/people.md` — entries from config/team.md + people discovered in scan
- `memory/projects.md` — seeded from Jira scan + domain config
- `memory/decisions.md` — empty with header (or seeded from scan if decisions found)
- `memory/recurring.md` — seeded from calendar scan
- `memory/suppliers.md` — seeded from domain config + any suppliers found in scan
- `memory/okrs.md` — seeded from Confluence scan if OKR pages found, otherwise empty
- `memory/tech-landscape.md` — seeded from domain config + website research
- `memory/comms-style.md` — seeded with user's stated communication preference

Only create files that don't already exist (preserve existing memory on re-setup).

### Phase 8: Done

Say:
```
chiefOS is configured and ready.

Your personalised CLAUDE.md has been generated and memory is seeded from your tools.

Here's what you can do now:

- `/briefing` — Get your morning intelligence brief
- `/signal-scan` — Quick cross-source situation check
- `/team-pulse` — Team health snapshot
- `/prep-1-2-1 [person]` — Prep for a 1-2-1
- `/learn [topic or URL]` — Teach me about something new

All skills are available. Run `/help` to see the full list.

chiefOS learns as you use it — the more you interact, the smarter it gets.
After a week of use, run `/setup check` to see your memory health.
```

---

## Sub-Command: `/setup regenerate`

1. Read all files in `config/`
2. Read all files in `core/`
3. Reassemble `CLAUDE.md` using the same logic as Phase 6
4. Report what changed

Use this after updating config files manually or after a framework update.

## Sub-Command: `/setup check`

1. Check that all 4 config files exist and are non-empty
2. Check that CLAUDE.md exists
3. Check that all memory files exist
4. Check memory health:
   - Count entries updated in the last 7 days
   - Flag files not updated in 30+ days
   - Check for empty memory files that should have content by now
   - Check for contradictions between memory files
5. Report findings with suggestions:
   - "memory/people.md has 3 entries — consider adding more context after your next round of 1-2-1s"
   - "memory/okrs.md is empty — run /okr-update to seed it from Confluence"
   - "memory/recurring.md hasn't been updated in 45 days — run /setup rescan to refresh"

## Sub-Command: `/setup add-person [name]`

1. Ask: What is [name]'s role, area, and what does "good" look like?
2. Ask: Are they a direct report or a stakeholder?
3. **Research them**: Search Gmail, Slack, and Calendar for [name] to find:
   - Email address, Slack handle
   - Recent communication topics
   - Shared meetings
   - Their communication style (formal/casual, response speed)
4. Present findings: "Here's what I found about [name] from your tools: [summary]. Should I save this?"
5. Add them to the appropriate section in `config/team.md`
6. Add a rich entry in `memory/people.md` with discovered context
7. Run `/setup regenerate` to update CLAUDE.md

## Sub-Command: `/setup update`

1. Read `.chiefos-version` for current version
2. Check if `core/`, `agents/`, `skills/`, `templates/` have been updated (manual or git pull)
3. If updated: run `/setup regenerate`
4. Report: "Framework updated to [version]. Config and memory preserved."

## Sub-Command: `/setup rescan`

Re-run the Phase 5 context scan on all connected tools. Useful when:
- New tools have been connected since initial setup
- Memory feels stale and needs a refresh
- The user's role or team has changed significantly

1. Read `config/integrations.md` for connected tools
2. Run the full Phase 5 scan
3. Present NEW findings only (skip what's already in memory)
4. Ask for confirmation before updating memory
5. Report: "[X] new entries added, [Y] entries updated, [Z] stale entries flagged"
