# Shared context for Claude and Codex

Both agents use [AGENTS.md](../../AGENTS.md) as the project guide and [memory/MEMORY.md](memory/MEMORY.md) as the index of durable project knowledge. `CLAUDE.md` imports the guide. Codex reads the guide automatically and follows its instruction to read the memory index.

Skills are shared the same way: each lives once in `.claude/skills/`, and `.agents/skills/` holds a symlink to it for Codex.

Keep conventions in `AGENTS.md`, decisions and their rationale in `memory/`, and current task state in `HANDOFF.md`. Update existing notes instead of keeping separate Claude and Codex copies. A handoff names its date and branch so the next session can check whether it still applies.

## Local configuration

These settings are per clone and ignored by Git. Merge them into existing settings without dropping permission rules, hooks or MCP servers.

### Claude memory

Point Claude's automatic memory at the shared directory by setting `autoMemoryDirectory` in `.claude/settings.local.json` to this clone's absolute path:

```json
{
  "autoMemoryDirectory": "/absolute/path/to/this-repo/docs/ai/memory"
}
```

Restart Claude afterwards. `/memory` should then show this directory.

## Verify the shared context

Ask each agent to summarise two memory notes and the Agent config block, citing the files it read. Memory changes should show up as normal changes in `git status`; `.claude/settings.local.json` should stay ignored.
