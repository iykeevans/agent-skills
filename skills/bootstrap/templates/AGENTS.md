# {{project_name}} — Shared Agent Instructions

## Shared Context

- This is the project guide for Claude and Codex. `CLAUDE.md` imports it and adds only Claude-specific guidance.
- At the start of a task, read `{{memory_dir}}/MEMORY.md`, then the notes relevant to the task. They are the shared project memory for both agents.
- Record durable decisions, user corrections, rationale and recurring pitfalls in `{{memory_dir}}/` (the `remember` skill). Update an existing note when one covers the topic, date substantive changes, and keep `MEMORY.md` a short linked index. Check a remembered code fact against the source before relying on it.
- Put temporary work state in `{{handoff_file}}` when handing work to another session or agent (the `handoff` skill). Read it when present and check its branch and date before acting on it. Completed task logs stay out of memory.
- Memory and the handoff are versioned project docs. Keep credentials and unrelated personal information out of them. Read a file before updating it so another agent's changes survive.

## Agent config

Skills read this block. Keys a project doesn't use can be deleted; a skill that needs a missing key asks for it.

```yaml
default_branch: main
protected_branches: [main, "release/*"]   # ship never pushes to these
branch_prefixes:                           # kind of change -> branch prefix
  feat: feat/
  fix: fix/
  chore: chore/
  refactor: refactor/
commit_style: conventional                 # conventional | plain
ai_attribution: false                      # Co-Authored-By trailers on agent commits
gates:                                     # run by ship before committing; omit one to skip it
  type_check: ""
  lint: ""
  test: ""
never_stage: [".env*", "!.env.example"]    # gitignore-style patterns ship leaves out unless told
tracker:
  kind: none                               # linear | jira | github | none
  issue_prefix: ""                         # e.g. ABC for ABC-123
  shipped_status: ""                       # state an issue moves to once its branch is pushed
compare_url: ""                            # e.g. https://github.com/<owner>/<repo>/compare/{branch}?expand=1
memory_dir: {{memory_dir}}
handoff_file: {{handoff_file}}
graphify: false                            # true: query the code graph before grepping
humanizer: false                           # true: run commit bodies and kept comments through the humanizer skill
feature_layout:                            # used by new-feature
  root: ""                                 # e.g. src/features/{feature}
  files: []                                # created for every feature, e.g. [index.ts]
  optional_files: []                       # created when asked, e.g. [types.ts, constants.ts]
  dirs: []                                 # e.g. [hooks]
  utils: folder                            # folder: utils/<name>/{index,<name>,<name>.test}; flat: utils/<name>.ts; none
  test_suffix: .test.ts
  filename_case: kebab                     # kebab | camel | pascal | snake
```

## Project Overview

{{overview}}

## Tech Stack

{{stack}}

## Repo Structure

{{structure}}

## Commands

{{commands}}

## Testing Conventions

{{testing}}

## Coding Conventions

- **Comments**: default to none. Keep one only if deleting it would let someone break something or make a correct line look like a bug: a platform or library quirk, a guard whose purpose isn't obvious, a trap in a tempting rewrite, a contract callers must meet. Delete comments that restate the code, narrate steps, or are stale, commented-out code or section banners, in the lines you change and the code around them. Lint and type directives get a short reason. Don't sweep untouched files in a feature change.
{{conventions}}

## Git Conventions

- Branch prefixes, commit style and AI attribution follow the Agent config block above.
- Commit subjects say what changed for the user in plain words, not which function moved.

## Skills

- Skills live in `.claude/skills/<name>/`, the only real copy. `.agents/skills/<name>` is a relative symlink to each so Codex finds the same skill; add both when you add a skill.
- Skills with a `.synced-from` file came from a shared repo. Edit them freely; a later sync leaves edited copies alone and prints the upstream diff.
