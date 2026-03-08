# Notes Integration

chiefOS supports multiple notes apps. The user's choice is stored in `config/integrations.md` under `notes_app`. Skills and agents must read this config before using notes tools.

**If `notes_app` is `none` or not set**: skip all notes/todo steps gracefully — never error, just suppress.

---

## Notee (notes_app: notee)

MCP server: `notes-app`

| Operation | Tool | Parameters |
|-----------|------|-----------|
| List notes | `list_notes` | — |
| Read note | `read_note` | `id` |
| Create note | `create_note` | `title`, `content` (markdown) |
| Update note | `update_note` | `id`, `title?`, `content?` |
| Search | `search_notes` | `query` |
| List todos | `list_todos` | `note_id?`, `status: all\|open\|done` |
| Toggle todo | `toggle_todo` | `note_id`, `line_number` |

**Notes**: Native todo support with checkbox tracking. Todos can be listed across all notes or filtered by note. Content is markdown.

---

## Apple Notes (notes_app: apple-notes)

MCP server: `Read_and_Write_Apple_Notes`

| Operation | Tool | Parameters |
|-----------|------|-----------|
| List notes | `list_notes` | `folder?`, `limit?` |
| Read note | `get_note_content` | `note_name`, `folder?` |
| Create note | `add_note` | `name`, `content`, `folder?` |
| Update note | `update_note_content` | `note_name`, `new_content`, `folder?` |
| Search | `get_note_content` | Search by `note_name` |
| List todos | `list_notes` → read each → parse `- [ ]` / `- [x]` lines |
| Toggle todo | `update_note_content` with checkbox toggled in content |

**Notes**: No native todo API — parse checkbox markdown from note content. Supports folders for organisation.

---

## Notion (notes_app: notion)

MCP server: user-configured (varies by MCP server implementation)

| Operation | Approach |
|-----------|----------|
| List notes | Search pages in workspace |
| Read note | Get page content by ID |
| Create note | Create page in configured database/parent |
| Update note | Update page content |
| Search | Search by query across workspace |
| List todos | Query todo database or parse checkbox blocks |
| Toggle todo | Update checkbox property or block |

**Notes**: Notion MCP servers vary. Read available tool names at runtime and match to operations above. Common MCP servers: `notion-mcp`, `@anthropic/notion-mcp`.

---

## Obsidian (notes_app: obsidian)

MCP server: user-configured (varies by MCP server implementation)

| Operation | Approach |
|-----------|----------|
| List notes | List files in vault directory |
| Read note | Read markdown file |
| Create note | Write new markdown file |
| Update note | Edit existing markdown file |
| Search | Search/grep vault content |
| List todos | Grep for `- [ ]` across vault files |
| Toggle todo | Edit file — replace `- [ ]` with `- [x]` or vice versa |

**Notes**: Obsidian vaults are local markdown files. Common MCP servers: `obsidian-mcp`, `@anthropic/obsidian-mcp`. Some use the Obsidian REST API plugin.

---

## How Skills Should Use This

1. Read `config/integrations.md` → find the `notes_app` value
2. If `none` or missing → skip notes steps, suppress notes sections in output
3. Otherwise → use the tool mapping above for the configured app
4. If a tool call fails → note "Notes integration unavailable" and continue without blocking
