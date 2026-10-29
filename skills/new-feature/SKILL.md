---
name: new-feature
description: Scaffold a new feature, or add a hook or util to one, in the folder layout the project declares in its Agent config. Use when the user asks to create, scaffold or start a feature or module, or to add a util/helper or hook to an existing feature.
---

# New feature

Creates the skeleton of a feature so it starts in the house shape instead of drifting. The layout comes from `feature_layout` in the `## Agent config` block of `AGENTS.md`; the idioms come from an existing feature. If `feature_layout.root` is empty, ask the user for the layout once, offer to save it to the block, and continue.

Args: the feature name, and optionally util or hook names to add. "Add a `formatPrice` util to checkout" is the same skill on an existing feature.

## 1. Find an exemplar

Pick the most recently changed feature under the layout root that already follows it (`git log` on the root, then check its tree against `feature_layout`). Read its main file, one hook, one util and its test. New files copy its imports, export style, test framework and naming. Never invent a pattern the repo doesn't use. With no exemplar yet, keep stubs minimal and say so in the report.

If `graphify: true`, use `graphify query`/`explain` to find the exemplar and its wiring before reading files.

## 2. Name things

- Feature folder: the name converted to `filename_case` (`Price Alerts` → `price-alerts` for kebab).
- Util file names convert the function name the same way (`formatPrice` → `format-price.ts`).
- If the folder or a file already exists, stop and show what's there. Don't overwrite.

## 3. Create

Under `root` with `{feature}` filled in:

- every entry in `files`; entries in `optional_files` only when asked or when the exemplar always has them;
- every entry in `dirs`, with a file in it only when the user named one (no empty placeholder files);
- utils, by `utils`:
  - `folder`: `utils/index.ts` re-exports each util folder (one `export * from "./<name>";` line each, alphabetical); `utils/<name>/index.ts` re-exports `./<name>`; `utils/<name>/<name>.ts` holds the function; `utils/<name>/<name><test_suffix>` imports `./<name>` directly. Consumers import from `utils`, never a subfolder.
  - `flat`: `utils/<name>.ts` with `utils/<name><test_suffix>` beside it.
  - `none`: no utils folder.
- Utils are pure: no UI framework, router or network imports, so their tests run without a renderer or server.

Stubs compile and lint clean: a typed signature that throws `not implemented` or returns a placeholder, and one test that pins the intended behaviour (it may fail until implemented; say so). Write no comments beyond what the exemplar would keep.

If the feature needs a route, page, endpoint registration or barrel entry elsewhere, show the line to add and where, and add it only if the user agrees. Wiring outside the feature folder is the user's call.

## 4. Check

Run the `type_check` and `lint` gates scoped to the new files if possible. If `graphify: true`, run `graphify update .` so the graph sees the new files.

## 5. Report

The tree created, the exemplar it followed, stubs that still need a real body, and any wiring left for the user.

## Example config

A React Native app keeping each feature under `components/`:

```yaml
feature_layout:
  root: apps/mobile/components/{feature}
  files: [index.tsx]
  optional_files: [types.ts, constants.ts]
  dirs: [hooks]
  utils: folder
  test_suffix: .test.ts
  filename_case: kebab
```
