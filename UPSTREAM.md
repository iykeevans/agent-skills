# Upstream skills

`tdd`, `diagnosing-bugs`, `codebase-design` and `codinary` are adapted from [igmrrf/agentic](https://github.com/igmrrf/agentic) at `d1c0d03`, under the MIT licence in [licenses/igmrrf-agentic.LICENSE](licenses/igmrrf-agentic.LICENSE). They are copied and edited here rather than installed as a plugin, so an upstream change reaches a project only through a reviewed diff.

## Taken and skipped

Taken: `diagnosing-bugs`, `tdd`, `codebase-design` (which `tdd` calls) and `codinary`. Upstream's `codinary/evals/` was left out; it tests the skill against upstream's own fixtures.

Skipped:

- `setup` runs an `init.sh` that writes a Biome config, generic CI and a generic `CLAUDE.md`, and its `CODING.md` style rules assume a particular toolchain. `bootstrap` here does the same job without choosing tools for the project.
- `code-review` shares its name with Claude Code's built-in `/code-review`, and it points at a `docs/agents/issue-tracker.md` and a `/setup-matt-pocock-skills` command that don't exist.
- `domain-modeling` keeps decisions in `CONTEXT.md` and `docs/adr/`. Projects using these skills keep them in the shared memory directory instead, and a second store would drift.

## Local edits

All small:

- A provenance line under each skill's title.
- "Read `CONTEXT.md` and ADRs" became "read the memory index and the relevant notes", located through `memory_dir` in the project's Agent config block.
- Layout, test placement and naming defer to the project's `AGENTS.md` and its `feature_layout`.
- Graphify before grep when the config has `graphify: true`, including in every subagent prompt (`codinary/references/roles.md`, `codebase-design/DESIGN-IT-TWICE.md`), since subagents don't load `AGENTS.md`.
- `codinary`: commits go through `ship`. Its mobile verification section tells the agent to find build, e2e and device notes in the project's own docs, and names the two-device cases (push, calls, chat).
- `diagnosing-bugs`: debug probes go through the project's logger where it has one, and keep the `[DEBUG-xxxx]` tag.

Project-specific detail (test runners, device quirks, logger package names) belongs in that project's synced copy as a local edit.

## Pulling upstream changes

Clone upstream at the new commit and diff each taken skill against `d1c0d03`. Port the parts worth having onto the copies here; never copy upstream files over them. Then update the commit id in this file and in each skill's provenance line, commit, and let projects pick it up with `scripts/sync.sh`.
