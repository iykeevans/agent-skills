# agent-skills

Skills for Claude Code and Codex, shared across projects. Both agents read the same files: a project keeps each skill once in `.claude/skills/<name>/`, and `.agents/skills/<name>` is a symlink to it.

Projects get copies, not a live dependency. A copy can be edited for that project, and a change here reaches a project only through a sync someone reviews.

## Skills

| Skill | What it does |
| --- | --- |
| `bootstrap` | Sets up a repo for agents: `AGENTS.md` with an `## Agent config` block, `CLAUDE.md`, shared memory, a handoff file. Run once per project (`/bootstrap`). |
| `remember` | Saves a durable project fact as a memory note and keeps the index current. |
| `handoff` | Writes or resumes `HANDOFF.md`, the temporary state passed between sessions and agents. |
| `ship` | Takes the working tree to a pushed branch: branch, gate, Conventional Commits, push, move the issue. |
| `new-feature` | Scaffolds a feature in the layout the project's config declares. |
| `tdd` | Red-green loop with rules for tests worth keeping. |
| `diagnosing-bugs` | A diagnosis loop for hard bugs and regressions: reproduce, hypothesise, probe, fix at the right seam. |
| `codebase-design` | Vocabulary for deep modules, seams and interfaces; `tdd` and `codinary` call it. |
| `codinary` | Brief to verified delivery with separate implementer, reviewer and fixer agents. Invoked only (`/codinary`), and costly; save it for big features. |

`tdd`, `diagnosing-bugs`, `codebase-design` and `codinary` are adapted from igmrrf/agentic; [UPSTREAM.md](UPSTREAM.md) has the details.

## Using it in a project

```sh
git clone https://github.com/iykeevans/agent-skills.git
agent-skills/scripts/sync.sh path/to/project            # every skill
agent-skills/scripts/sync.sh path/to/project ship tdd   # just these
```

Then run `/bootstrap` in the project (Claude) or ask Codex to use the bootstrap skill. It writes the files the other skills read, including the config block.

Sync again to pull updates. A copy that still matches the commit in its `.synced-from` is replaced. A copy with local edits is left alone and the upstream diff is printed so you can port it. Commit the synced files in the project like any other change.

## Per-project config

Skills here never hardcode a project's branch names, gate commands or tracker. They read a fenced YAML block under `## Agent config` in the project's `AGENTS.md`. `bootstrap` writes it, and [skills/bootstrap/templates/AGENTS.md](skills/bootstrap/templates/AGENTS.md) documents every key. A skill that needs a key the block doesn't have asks for the value and offers to add it.

## Writing a skill here

This repo is public. Keep project names, issue ids, internal URLs and anything from a project's memory out of it. Use placeholders (`ABC-123`, `yarn test`) in examples. Anything project-specific belongs in that project's copy as a local edit.
