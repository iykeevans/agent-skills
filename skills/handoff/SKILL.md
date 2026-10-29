---
name: handoff
description: Write or resume the handoff file that carries in-progress work between sessions and between Claude and Codex - branch, date, what's done, decisions, failed approaches, next steps. Use when the user says "handoff", "write a handoff", "pick up where we left off", "resume", or before ending a session with unfinished work.
---

# Handoff

`handoff_file` comes from the `## Agent config` block in `AGENTS.md` (default `docs/ai/HANDOFF.md`). It holds one piece of in-progress work. Durable lessons go to memory through the `remember` skill; the handoff is for state that stops mattering once the work lands.

Decide the mode from the request: **write** when ending or pausing work, **resume** when starting from it.

## Write

1. Read the current file. If it describes other unfinished work, ask before replacing it.
2. Gather facts, don't recall them: `git branch --show-current`, `git rev-parse --short HEAD`, `git status --short`, and the results of the last gate or test run if this session ran one.
3. Write:

```markdown
# Handoff — <the work, in a few words>

- **Date:** <YYYY-MM-DD>
- **Branch:** `<branch>` at `<short sha>`, <clean | N uncommitted files>
- **State:** <one line: planning / half implemented / done, unverified / blocked on X>

## Task
What the user asked for and the scope they chose, in their terms.

## Done
What changed, grouped by area, with file paths.

## Decisions
Each choice and its reason, including what the user decided.

## Verified
Commands run and their results. Only what was actually run in this session.

## Not verified / open
Anything assumed, untested or still unknown. Mark guesses as guesses.

## Failed approaches
What was tried and why it didn't work, so nobody tries it again.

## Next steps
Concrete and ordered, specific enough to start without asking.
```

4. Keep facts and assumptions apart. Don't invent history the session doesn't have.
5. Move anything that will still matter after this work merges into memory with `remember`, and link it from the handoff.
6. No credentials or tokens. Don't commit unless asked.

## Resume

1. Read the file. If it says there's no work in progress, say so and stop.
2. Compare its branch and sha with `git branch --show-current` and `git log`. If the branch differs, or commits landed after the recorded sha, tell the user what doesn't match before acting on it.
3. Re-check the claims your next step depends on, against the code. A handoff can be stale.
4. Summarise for the user: the task, the state, and the first next step. Ask before starting if anything didn't match.
5. Once the work is merged or abandoned, reset the file to the empty state (`No work in progress.`).
