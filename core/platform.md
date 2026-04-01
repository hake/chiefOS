# Platform Detection & Dual-Mode Behavior

chiefOS runs on both **Claude Code** (CLI) and **Claude Cowork** (Desktop). This module defines how to detect the environment and adapt behavior accordingly.

## Environment Detection

Determine the current platform before executing any skill:

1. **Check for Cowork markers**:
   - Directory `~/.claude/projects/` exists with project subdirectories
   - Session is running inside the Claude Desktop app's sandboxed VM
   - The `claude_desktop_config.json` MCP configuration is present
2. **Check for Claude Code markers**:
   - Running in a terminal/CLI session
   - Standard Claude Code plugin directory structure
3. **Fallback**: If no Cowork markers are detected, assume Claude Code

## Execution Modes

chiefOS skills run in two modes, independent of platform:

### Foreground Mode (Default)
The user is present and can answer questions. This is the normal mode for both Claude Code and Cowork.

- **Interactive**: Ask clarifying questions, offer revision options, request confirmation before writing memory
- **Full experience**: All skill features work — conversational setup, draft review loops, follow-up offers
- **Both platforms support this**: The `/setup` wizard, `/comms-draft` revision offers, `/draft-prd` requirements gathering, etc. all work in both Claude Code and Cowork

### Background Mode (Scheduled/Dispatched)
The skill is running without a user present — triggered by a schedule, dispatched via Claude Dispatch, or invoked as a background sub-agent. No one is there to answer questions.

- **Non-interactive**: Never ask mid-run questions; use defaults or pre-configured parameters
- **Accept all parameters upfront**: Skills must work with the arguments provided at invocation time
- **Save output directly**: Write reports to `reports/` without asking for confirmation
- **Skip revision offers**: Do not offer "Want me to make it shorter/longer?" or similar
- **Use config data as ground truth**: If information is missing, note the gap in output rather than asking

**How to detect background mode**: The skill is running as a scheduled task, was invoked by Claude Dispatch without a live user session, or is executing as a sub-agent spawned by another skill via the Agent tool.

## Platform-Specific Behavior

| Aspect | Claude Code | Cowork |
|--------|------------|--------|
| **Interaction** | Foreground (interactive) | Foreground (interactive) |
| **Context budget** | `large` — full scans, verbose output | `conservative` — 200K window, summarize more aggressively |
| **Memory path** | `./memory/` relative to project root | `./memory/` first, fall back to `~/.claude/projects/<project>/memory/` |
| **MCP config** | `config/integrations.md` at runtime | `claude_desktop_config.json` + `config/integrations.md` for chiefOS settings |
| **Scheduling** | Via cron or Claude Code headless API | Via Claude Dispatch (background mode applies) |

## Context Budget Guidelines (Cowork)

Cowork has a 200K context window (vs 1M in Claude Code). When running in Cowork, skills should:

- **MCP scan results**: Limit to top 10 items per source (Gmail, Slack, Jira, Calendar)
- **Memory reads**: For entries older than 7 days, include only the subject line and date — not full details
- **Report output**: Keep to ~80% of normal length; tighter bullets, fewer examples
- **Convergence detection**: Surface a maximum of 3 cross-source patterns
- **Sub-agent responses**: Agents should return concise JSON; omit `raw_reference` fields unless urgent

## How Skills Should Reference This Module

Skills that have interactive elements AND may be run as scheduled/background tasks should include a "Background Mode" section near the top:

```markdown
## Background Mode (Scheduled/Dispatched)
When running without a user present (see `core/platform.md`):
- [specific behavior changes for this skill]
- Save output directly to reports/ without asking
- Use defaults for any normally-interactive choices
```

This section is NOT triggered by being in Cowork — it is triggered by the absence of a live user session.

## MCP Integration Notes

- **Claude Code**: MCP tools are configured in `config/integrations.md` and checked at runtime
- **Cowork**: MCP tools are configured in `claude_desktop_config.json` by the user before launching
- **Both**: Skills should still read `config/integrations.md` for chiefOS-specific settings (Jira project keys, Slack channels, notes app choice). The MCP connection itself is handled by the platform.
- **Graceful degradation**: If an MCP tool call fails, suppress that section — do not error out. This applies to both platforms.
