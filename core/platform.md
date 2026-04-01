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

## Behavioral Switches

Based on the detected platform, apply these switches:

| Switch | Claude Code | Cowork |
|--------|------------|--------|
| `interactive_mode` | `true` — ask clarifying questions mid-run | `false` — never ask mid-run; use defaults or pre-configured parameters |
| `context_budget` | `large` — full scans, verbose output | `conservative` — summarize aggressively, limit scan depth |
| `memory_path` | `./memory/` relative to project root | `./memory/` first, fall back to `~/.claude/projects/<project>/memory/` |
| `setup_mode` | Interactive wizard (`/setup`) | Pre-fill config + auto mode (`/setup auto`) |

## Non-Interactive Mode Rules

When `interactive_mode = false` (Cowork or background sub-agent execution):

1. **Never ask questions mid-execution** — if a skill normally asks the user for input, use the default option or infer from config/memory
2. **Accept all parameters upfront** — skills must work with the arguments provided at invocation time
3. **Save output directly** — write reports to `reports/` without asking for confirmation
4. **Skip revision offers** — do not offer "Want me to make it shorter/longer?" or similar
5. **Use config data as ground truth** — if information is missing, note the gap in output rather than asking

## Context Budget Guidelines (Cowork)

When `context_budget = conservative`, skills should:

- **MCP scan results**: Limit to top 10 items per source (Gmail, Slack, Jira, Calendar)
- **Memory reads**: For entries older than 7 days, include only the subject line and date — not full details
- **Report output**: Keep to ~80% of normal length; tighter bullets, fewer examples
- **Convergence detection**: Surface a maximum of 3 cross-source patterns
- **Sub-agent responses**: Agents should return concise JSON; omit `raw_reference` fields unless urgent

## How Skills Should Reference This Module

Every skill that has interactive elements should include a "Non-Interactive Mode" section near the top. The pattern is:

```markdown
## Non-Interactive Mode (Cowork)
When running in non-interactive mode (see `core/platform.md`):
- [specific behavior changes for this skill]
- Save output directly to reports/ without asking
- Use defaults for any normally-interactive choices
```

Skills that are fully autonomous (no mid-run questions) do not need this section.

## MCP Integration Notes

- **Claude Code**: MCP tools are configured in `config/integrations.md` and checked at runtime
- **Cowork**: MCP tools are configured in `claude_desktop_config.json` by the user before launching
- **Both**: Skills should still read `config/integrations.md` for chiefOS-specific settings (Jira project keys, Slack channels, notes app choice). The MCP connection itself is handled by the platform.
- **Graceful degradation**: If an MCP tool call fails, suppress that section — do not error out. This applies to both platforms.
