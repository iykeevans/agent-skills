---
name: bootstrap
description: Set up a repository for Claude and Codex to share - AGENTS.md with the Agent config block the other skills read, CLAUDE.md importing it, a shared memory directory, a handoff file, and .agents/skills symlinks. Use when the user invokes /bootstrap or asks to set up agent instructions, shared memory or the Agent config in a repo.
disable-model-invocation: true
---

# Bootstrap

Prepares a repo so the other skills work: `ship`, `remember`, `handoff` and `new-feature` read the `## Agent config` block this writes. Run it once per project, and again to fill in config keys added later.

Templates are in `templates/` next to this file. Never overwrite an existing file without showing the user what changes and getting a yes.

## 1. Look at the repo

- Confirm it is a git repo and note the default branch (`git symbolic-ref refs/remotes/origin/HEAD`, else the current branch).
- Read any existing `AGENTS.md`, `CLAUDE.md`, `.claude/settings.json`, `docs/ai/`. If `AGENTS.md` already has an `## Agent config` block, this run only fills in missing keys and broken links; say so and skip to step 4.
- Work out the stack from manifests (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `Gemfile`, `Makefile`, …), the lockfile (which package manager), the folder layout, and CI workflows. CI is the best source for the real gate commands.
- Look at `git log --oneline -30` for the branch and commit style already in use.

## 2. Propose the config

Draft every key from the template's config block using what you found. Then ask the user only about what you could not infer, in one round (the AskUserQuestion tool when available):

- the tracker (`linear`, `jira`, `github`, `none`), its issue prefix, and the status an issue moves to once its branch is pushed;
- whether agent commits carry AI attribution trailers;
- the feature layout, if the repo has no feature folder to copy it from yet;
- whether the project uses graphify and the humanizer skill.

Show the drafted block and let the user correct it before writing.

## 3. Write the files

From `templates/`, substituting `{{…}}` placeholders:

| File | Notes |
| --- | --- |
| `AGENTS.md` | Fill Overview, Stack, Structure, Commands and Testing from step 1, in a few factual lines each. If the user hasn't said, leave a `TODO:` line rather than guessing. Merge into an existing `AGENTS.md` section by section and keep its content. |
| `CLAUDE.md` | `@AGENTS.md`. If one exists, add the import line at the top and keep the rest. |
| `<memory_dir>/MEMORY.md` | Index only. |
| `<handoff_file>` | The empty-state template. |
| `docs/ai/README.md` | Per-clone setup notes; adjust paths if `memory_dir` differs. |

`memory_dir` defaults to `docs/ai/memory` and `handoff_file` to `docs/ai/HANDOFF.md`.

## 4. Links and local settings

- For each folder in `.claude/skills/`, make sure `.agents/skills/<name>` is a symlink to `../../.claude/skills/<name>`. Create missing ones; report any that point elsewhere and leave them.
- Make sure `.gitignore` covers `.claude/settings.local.json` (and `graphify-out/graph.json` if graphify is on).
- Offer to set `autoMemoryDirectory` in `.claude/settings.local.json` to the absolute path of `<memory_dir>`, so Claude's automatic memory writes into the shared directory. The file is per clone; merge into it, never replace it.
- If `graphify: true`, point the user to `graphify hook install` rather than running it.

## 5. Report

List files created, files merged (with what was added), symlinks made, config keys left empty, and `TODO:` lines that need a human. Don't commit. Suggest `ship` with a `chore` commit once the user has read the result.
