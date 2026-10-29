---
name: remember
description: Save a durable project fact - a decision and its reason, a user correction, a recurring pitfall, a bug's real cause - as a shared memory note and keep the index current. Use when the user says "remember", "note that", "add to memory", when a session settles a decision future work depends on, or when a diagnosed bug had a non-obvious cause.
---

# Remember

Memory is versioned project documentation both agents read at the start of a task. `memory_dir` comes from the `## Agent config` block in `AGENTS.md` (default `docs/ai/memory`); its `MEMORY.md` is the index.

## What belongs

Save what someone could not recover from the code or `git log`:

- a decision and why it was made, especially when the obvious alternative was rejected;
- a correction the user gave about how to work, and the reason;
- a cause that took real work to find, and the wrong theories ruled out on the way;
- a constraint from outside the repo (a dashboard setting, a store rule, a vendor limit).

Leave out what the repo already records (code structure, conventions already in `AGENTS.md`, past diffs), what matters only to the current task (that goes in the handoff), and anything secret. If the user asks to remember something in the first group, ask what was non-obvious about it and save that.

## 1. Check for an existing note

Read `MEMORY.md` and any note whose title or hook is close. If one covers the topic, update it: change the facts, bump `modified`, add a dated line for a substantive change. Delete a note that turned out to be wrong, and its index line. Never write a second note on the same topic.

## 2. Write the note

One topic per file, `<memory_dir>/<kebab-slug>.md`. The slug names the fact, not the task (`dates-use-shared-constants.md`, not `fix-123.md`).

```markdown
---
name: <kebab-slug>
description: "<one line used to decide whether to load this note>"
metadata:
  type: project | feedback | reference
  modified: <YYYY-MM-DD>
---

# <Title>

<The fact, stated plainly. Absolute dates, never "last week". Name files, values, ids exactly.>

**Why:** <the reason or the incident behind it>

**How to apply:** <what to do, or not do, the next time this comes up>
```

- `project`: decisions, constraints, causes. `feedback`: how the user wants agents to work. `reference`: where something lives outside the repo.
- Link related notes with `[[their-slug]]`. A link to a note that doesn't exist yet is fine; it marks one worth writing.
- Code facts drift. Name the file or symbol so the next reader can check it still holds.
- If `humanizer: true` in the config, run the body through the humanizer skill.

## 3. Update the index

One line per note in `MEMORY.md`, under the intro paragraph:

```markdown
- [Title](slug.md) — what it says, short enough to scan.
```

Keep the index a list of pointers. No content goes there that isn't in a note.

## 4. Report

The note's path, whether it was new, updated or deleted, and its index line. Don't commit unless asked; memory changes ship with the work that produced them.
