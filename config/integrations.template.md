# Integrations — Fill This Before Running /setup auto
#
# Instructions for Cowork users:
# 1. Copy this file to config/integrations.md
# 2. Check [x] the MCP tools you have connected in Claude Desktop settings
# 3. Fill in the configuration sections for enabled tools
# 4. Delete these instruction comments
# 5. Run /setup auto
#
# Note: MCP server connections are configured in Claude Desktop's
# claude_desktop_config.json. This file tells chiefOS which tools
# are available and provides chiefOS-specific settings (project keys, channels, etc.)

## MCP Tools Available
- [ ] Gmail
- [ ] Google Calendar
- [ ] Slack
- [ ] Jira/Confluence
- [ ] Notes app

## Notes Configuration
- **notes_app**: none
  Options: notee | apple-notes | notion | obsidian | none
  See core/notes-integration.md for tool mapping.

## Jira Configuration (if enabled)
- **Project keys**: [comma-separated, e.g. PROJ, TEAM]
- **Squad mapping**:
  - [Project key] → [Direct report name]

## Confluence Configuration (if enabled)
- **OKR space**: [space key]
- **Team space**: [space key]

## Slack Configuration (if enabled)
- **Key channels**: [channels to monitor, e.g. #engineering, #team-updates]
- **Team channel**: [primary team channel]
