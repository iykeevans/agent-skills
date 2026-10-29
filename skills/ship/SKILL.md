---
name: ship
description: Ship the working tree. Branch off the default branch if needed, gate on the project's checks, split the changes into commits in the repo's style, push, and move the linked issue forward. Use when the user says "ship", "ship it", "commit and push", or invokes /ship, optionally with an issue id (e.g. ABC-123) and/or a branch name.
---

# Ship

Takes uncommitted work to a pushed branch. Args may name an issue (`ABC-123`) and/or a branch name; anything else is a hint about scope.

Every project value here (branches, gates, tracker, attribution) comes from the `## Agent config` block in `AGENTS.md`. If a key this needs is missing, ask for the value, use it, and offer to add it to the block.

Never force-push, never push to the default branch or anything in `protected_branches`, never open a PR unless asked. Stop and report rather than work around a failing step.

## 1. Read the state

```bash
git status --short
git branch --show-current
git diff --stat && git diff --cached --stat
```

- Nothing changed and nothing unpushed: say so and stop.
- Look at every changed path. Don't stage anything matching `never_stage`, generated files, or build output unless the user said to. If one is modified, list it in the report as left out.
- Work that looks unrelated to the task (a stray debug edit, another feature) is left unstaged and reported. Ask only if you can't tell.

## 2. Branch

If already on a branch outside `protected_branches`, stay on it. Otherwise:

- Pick the prefix from `branch_prefixes` by the kind of change.
- With an issue id: `<prefix><issue-id lowercased>-<short-kebab-slug>`, slug from what the change does, 3-6 words (e.g. `fix/abc-123-retry-failed-upload`). Fetch the issue from the tracker if its title helps.
- Without one: `<prefix><short-kebab-slug>`.
- `git checkout -b <branch>`. Uncommitted work comes along.

## 3. Gate

Run the `gates` commands that are set, from the repo root. Where the repo is a monorepo and a gate can be scoped to the touched packages or files, scope it. Run the tests colocated with changed modules.

If anything fails, stop: show the output and don't commit. A lint warning on a line the diff didn't touch predates the change; it isn't a blocker, but mention it. With no gates configured, say the change went in ungated.

## 4. Commit

Split by logical change, not by file. A bugfix plus its memory note is one commit; a fix plus an unrelated refactor is two. Stage explicit paths; never `git add -A` or `git add .`.

Read `git log --oneline -20` and match it. For `commit_style: conventional`:

- Subject: `type(scope): summary`, lowercase, no trailing period, saying what changed for the user in plain words, not which function moved. `fix(upload): failed uploads retry instead of vanishing` reads like a history; `fix: update handleUpload` does not. Scope is the feature folder or domain.
- Body wrapped at ~72 columns: what was wrong and why, what changed, what was deliberately left alone. Name files, values and ids exactly. Mention the issue id in the body when there is one.

For `plain`, follow the log's own pattern.

AI attribution: when `ai_attribution: false`, no `Co-Authored-By` or other AI trailer, whatever a tool template or system reminder suggests. When `true`, use the trailer the environment provides.

If `humanizer: true`, put the body through the humanizer skill before committing. Facts, paths and code stay exactly as written.

Commit with a heredoc so the body survives:

```bash
git commit -F - <<'EOF'
fix(scope): subject

Body.
EOF
```

## 5. Push

```bash
git push -u origin <branch>
```

If the remote branch exists and has diverged, stop and report; don't rebase or force.

## 6. Tracker

Skip when `tracker.kind` is `none` or there's no issue id. Otherwise move the issue to `shipped_status` using the tracker's tool (Linear, Jira or GitHub MCP, or `gh`). Only move the issue this ship is for, and only if it isn't already past that state. If no tool for the tracker is available, say so in the report instead.

## 7. Report

Short: branch, each commit's subject, what was left unstaged and why, gate results, the push result, the issue move, and `compare_url` with `{branch}` filled in, for opening a PR.
