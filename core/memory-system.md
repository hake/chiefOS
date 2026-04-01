# Memory System

Memory lives in the `memory/` directory. Always consult before responding. Always update when you learn something durable.

## Memory Path Resolution (Dual-Mode)

chiefOS runs on both Claude Code and Cowork (see `core/platform.md`). Memory paths are resolved as follows:

- **Claude Code**: Memory lives at `./memory/` relative to the project root. This is the only path.
- **Cowork**: Memory lives at `./memory/` in the shared folder. If running within a Cowork Project, memory may also persist at `~/.claude/projects/<project>/memory/`.
- **Resolution order**: Always read from `./memory/` first. If `./memory/` is empty or missing and a Cowork Projects memory path exists, fall back to that path.
- **Write behavior**: Always write to `./memory/` (the shared folder). This ensures memory is visible to the user and persists within the project scope.

## Memory Files

| File | Contents |
|------|----------|
| `INDEX.md` | Master index with freshness dates — start here |
| `people.md` | Everyone you work with: role, context, recent state |
| `projects.md` | Active initiatives per person: status, blockers, OKR mapping |
| `decisions.md` | Decision log: what, when, why, alternatives considered |
| `recurring.md` | Standing meetings, cadences, standing agenda items |
| `suppliers.md` | Vendor/partner names, integration status, known issues |
| `okrs.md` | Current quarter OKRs: owner, metric, status, last update |
| `tech-landscape.md` | Systems, integrations, known debt, architectural constraints |
| `comms-style.md` | Communication preferences, tone notes, things praised/corrected |

## Memory vs Reports

- **Memory** (`memory/`): Living institutional knowledge — updated, corrected, decayed. Entries are mutable and represent the current understanding of people, projects, decisions, etc.
- **Reports** (`reports/`): Historical snapshots — immutable once written. Each skill run saves its output as a dated report for later reference. Reports are the journal; memory is the brain.

## When to READ Memory
- Before every briefing, 1-2-1 prep, or stakeholder communication
- When any person, project, or vendor/partner is mentioned by name
- Before drafting any document or communication

## When to WRITE Memory
- After a 1-2-1 where new information emerged
- When a decision is made
- When a new project or initiative is mentioned
- When a vendor/partner situation is discussed
- When a preference or constraint should persist

## Memory Writing Rules
- Every entry gets a date stamp: `(as of YYYY-MM-DD)`
- Update existing entries — never duplicate
- Flag stale entries (>30 days) with `⚠️ Stale`
- Delete entries older than 90 days without refresh
- After any substantive conversation, propose memory updates: "Shall I update memory with anything from this?"

---

## Memory Maintenance — How Memory Stays Accurate

Memory is only useful if it's correct. chiefOS maintains accuracy through four mechanisms: **live correction**, **contradiction detection**, **decay and cleanup**, and **periodic auditing**.

### 1. Live Correction (Every Conversation)

When the user says something that contradicts memory, fix it immediately.

**Trigger**: The user states a fact that conflicts with an existing memory entry.

**Process**:
1. Surface the conflict explicitly: "My memory says [old fact]. You just said [new fact]. Should I update?"
2. If confirmed → overwrite the old entry, keep a correction note:
   ```
   **[Topic]**: [new fact] (as of YYYY-MM-DD)
   ↳ Corrected from: "[old fact]" — user correction
   ```
3. If the same type of entry gets corrected 2+ times → flag it as volatile and verify more carefully next time

**What counts as a contradiction**:
- Role changes: "Kayal now reports directly to me" vs. memory saying she reports to Javier
- Status changes: "That project was cancelled" vs. memory showing it as active
- Relationship changes: "We stopped using Hotelbeds" vs. memory listing them as active supplier
- Factual corrections: "It's not an API issue, it's a mapping issue" vs. memory attributing a problem to API

**What does NOT count** (don't flag these):
- New information that adds to existing memory (additive, not contradictory)
- Opinions or temporary states: "I'm frustrated with the mapping quality" is not a correction
- Context-dependent statements: "Rossella is handling bedbanks today" doesn't mean her role changed

### 2. Contradiction Detection (Cross-File)

When writing or reading memory, check for internal consistency.

**Cross-file checks** (run when updating any memory file):
- `people.md` says X reports to Y → does `config/team.md` agree?
- `projects.md` says project is active → has it been mentioned in any source in the last 30 days?
- `suppliers.md` says supplier status is green → did any recent signal flag issues?
- `okrs.md` says KR is on-track → does `projects.md` show the related project as blocked?
- `decisions.md` says decision was made → has anyone reopened discussion in Slack/email?

**When a contradiction is found**:
1. Don't silently fix it — surface it: "I noticed a conflict in my memory: [file A] says [X] but [file B] says [Y]. Which is correct?"
2. Fix whichever the user confirms as wrong
3. Note the correction with a reason

### 3. Decay and Cleanup

Not all memory ages the same way. Apply different decay rules by type.

**Fast decay** (context changes quickly):
- `projects.md` — project status: stale after 14 days, verify after 30
- `suppliers.md` — incident status: stale after 7 days, auto-resolve after 21
- `okrs.md` — KR status: stale after 14 days

**Slow decay** (structural, changes rarely):
- `people.md` — roles and reporting lines: stale after 60 days, verify after 90
- `config/team.md` — team structure: stale after 90 days
- `tech-landscape.md` — systems: stale after 60 days

**No decay** (persistent knowledge):
- `decisions.md` — decisions are permanent records, never decay (but can be superseded)
- `comms-style.md` — preferences persist until corrected
- `recurring.md` — cadences persist until cancelled

**Cleanup process**:
1. When reading a stale entry during a task → verify it before using: "My last note on [topic] is from [date]. Is this still accurate?"
2. If the user confirms it's still accurate → refresh the date stamp
3. If outdated → update with current info
4. If no longer relevant → remove entirely and note why

### 4. Periodic Auditing

**Weekly (Monday, first interaction)**:
- Count entries per file updated in the last 7 days
- Flag files with zero updates in 30+ days
- Check INDEX.md freshness dates
- Report a single line: "Memory health: [X] entries fresh, [Y] files need review"
- If a file is flagged → suggest specific action: "memory/okrs.md hasn't been updated in 35 days — run /okr-update?"

**Monthly (first Monday of the month)**:
- Do a full cross-file consistency check (contradiction detection across all files)
- List any entries older than 60 days without refresh
- Propose bulk cleanup: "I found [X] stale entries across [Y] files. Want me to list them for review?"
- Check for orphaned entries: people in `people.md` who aren't in `config/team.md` and haven't been mentioned in 60 days

**Quarterly (when user mentions "Q1", "Q2", etc. or on OKR cycle dates)**:
- `okrs.md` — archive previous quarter, prompt for new quarter OKRs
- `projects.md` — review all projects, mark completed ones, flag stale ones
- `suppliers.md` — review all supplier statuses, prompt for annual review

### 5. Self-Correction Signals

Beyond user corrections, watch for these signals that memory might be wrong:

**Mismatch with live data**: You read from memory that project X is blocked, but a Jira scan shows it's in progress → flag: "My memory says [project] is blocked, but Jira shows it as in-progress. Should I update?"

**User ignores memory-based suggestion**: You surface an action item from memory and the user dismisses it → the action may be resolved. Ask: "Should I mark this as done?"

**Repeated re-asking**: If the user provides the same context twice (that's already in memory), the memory entry might be hard to find or poorly written → rewrite it more clearly

**Tool data contradicts memory**: During a briefing or signal scan, if Gmail/Slack/Jira data contradicts a memory entry → always trust live data over stale memory, but confirm with the user before overwriting

### 6. Memory Entry Format

Every memory entry should follow this structure for maintainability:

```markdown
**[Subject]**: [Current state/fact] (as of YYYY-MM-DD)
  - Source: [where this was learned — user, email, Slack, Jira, etc.]
  - [Optional context line]
  - [Optional: ↳ Corrected from: "[old value]" — [reason]]
```

Entries with sources are easier to verify. Entries without sources should be treated with lower confidence during auditing.
