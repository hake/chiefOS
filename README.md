# chiefOS

Your AI Chief of Staff. A productivity suite for managers that gives you institutional memory, cross-source signal scanning, team health monitoring, OKR tracking, and communication drafting — all powered by Claude Code.

## Install as Claude Code Plugin

```bash
# Add as a marketplace (one-time)
/plugin marketplace add saulhenriques/chiefOS

# Install
/plugin install chief-os@saulhenriques/chiefOS
```

Then in any project directory:
```
/chief-os:setup
```

## Install in Claude Cowork (Desktop)

### From the marketplace

1. Open **Claude Desktop** and go to the **Cowork** tab
2. Click **Customize** in the left sidebar
3. Click **Browse plugins** and search for **chief-os**
4. Click **Install**
5. Run `/chief-os:setup` in the chat to configure

### Manual upload

1. Download the latest release ZIP from [GitHub](https://github.com/saulhenriques/chiefOS/releases) (or clone and zip the repo)
2. Open **Claude Desktop** → **Cowork** tab
3. Click **Customize** → **Browse plugins** → click the **"+"** button
4. Select the ZIP file
5. Once uploaded, run `/chief-os:setup` to configure

You can also access skills from the **+** menu → **Plugins** → **chief-os**.

## Alternative: Standalone Install

```bash
# Clone and install
git clone https://github.com/saulhenriques/chiefOS.git /tmp/chiefOS
/tmp/chiefOS/install.sh ~/chiefOS

# Open in Claude Code
cd ~/chiefOS

# Run interactive setup (5 minutes)
/setup
```

## What You Get

| Skill | What It Does |
|-------|-------------|
| `/briefing` | Morning intelligence brief — calendar, emails, Slack, blockers, OKR pulse |
| `/signal-scan` | Cross-source signal ranking (Slack + Gmail + Jira + Calendar) |
| `/team-pulse` | Team health one-liner per direct report with evidence |
| `/prep-1-2-1 [person]` | 1-2-1 meeting prep with context and open actions |
| `/risk-radar` | Blocked/overdue items across all active projects |
| `/okr-update` | Live OKR status dashboard from Confluence/Jira/Slack |
| `/okr-narrative` | Written OKR progress story for stakeholders |
| `/weekly-retrospective` | Friday wrap + next week preview |
| `/stakeholder-brief [topic]` | Strategic brief for your boss on any topic |
| `/supplier-watch` | Vendor/partner health dashboard |
| `/decision-log` | Extract and persist decisions from recent conversations |
| `/hiring-track` | Recruitment pipeline from email/Slack/notes |
| `/comms-draft [type] [topic]` | Audience-aware communication drafting |
| `/draft-prd [feature]` | Product Requirements Document drafting |
| `/onboarding-brief [person]` | Context doc for new team members |
| `/daily-ops` | Daily operational patterns and weekly catchup |
| `/meeting-actions` | Post-meeting action extraction, classification, and todo creation |
| `/setup` | Interactive onboarding and configuration wizard |

## How It Works

chiefOS uses **config-driven generation**:

1. `config/` — Your identity, team, domain knowledge, and integrations (markdown files)
2. `core/` — Generic framework modules (operating principles, memory system, audience matching)
3. `CLAUDE.md` — Generated from config + core by `/setup`
4. `memory/` — Persistent knowledge that grows with every interaction
5. `.claude/skills/` — 18 skills that read your config at runtime
6. `.claude/agents/` — 8 sub-agents for parallel data gathering

## MCP Integrations

chiefOS works best with these MCP tools connected:
- **Gmail** — email scanning and drafting
- **Google Calendar** — schedule awareness
- **Slack** — message and signal scanning
- **Jira/Confluence** — ticket tracking and OKR pages
- **Notes app** — todo management

Skills gracefully degrade when integrations aren't configured.

## Updating

```
/setup update
```

Or manually: replace `core/`, `agents/`, `skills/`, `templates/` with the latest version, then run `/setup regenerate`.

## Directory Structure

```
chiefOS/
├── .claude-plugin/
│   └── plugin.json        # Plugin manifest
├── CLAUDE.md              # Generated — do not edit directly
├── core/                  # Framework modules (update-safe)
├── config/                # Your personal configuration
├── templates/             # Starter configs by role
├── memory/                # Persistent knowledge (grows over time)
├── memory-templates/      # Clean templates for /setup seeding
├── skills/                # 18 skills (plugin convention)
├── agents/                # 8 sub-agents (plugin convention)
└── .chiefos-version       # Framework version
```
