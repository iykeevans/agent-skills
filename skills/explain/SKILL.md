---
name: explain
description: Explain a concept, a piece of code, or the previous answer in Simplified Technical English (ASD-STE100 style) on a page with diagrams. Use when the user says "explain", "/explain", "explain last", "break this down", "I don't understand this", or asks for a plain or STE version of an answer.
---

# Explain

Turn dense content into a page a reader can follow: short sentences in Simplified Technical English (STE), one meaning per word, and diagrams that show the real mechanism. The page is HTML with inline SVG, so it reads well in light and dark mode and on a phone.

This is STE-style, not certified ASD-STE100. The official dictionary is licensed; `references/ste-words.md` holds a short working list. Do not call the output "STE compliant".

## Arguments

- `last` or no argument: explain the previous assistant answer in this conversation.
- Anything else: the topic, for example `how the request proxy works` or a file path.

## 1. Collect the source

- For `last`, take the previous answer as the source. Do not add facts that it does not hold.
- For a topic in the current repo, read the code first. Note real `path:line` references for each part you explain.
- For a general topic, use what you know, and mark claims you are not sure of.
- If the source is unclear or contradicts itself, say so on the page. Do not hide the gap.

## 2. Break the concept into units

Write down, before any prose:

- **Terms**: each noun the reader must know. Pick one name per thing and keep it everywhere. If the source uses two names for one thing, choose one and note the other in the terms table.
- **Parts**: the components, files or actors.
- **Flow**: what happens, in order, and what starts it.
- **States**: values or statuses that change, if any.

The units drive both the text and the diagrams. A part that appears in the text must have the same name in the diagram.

## 3. Write the text in STE rules

Read `references/ste-rules.md` for the rules and examples, and `references/ste-words.md` for the word list. The core:

- Procedural sentence (a step): 20 words or fewer. Descriptive sentence: 25 words or fewer.
- One instruction per sentence. Use the imperative for steps: "Open the file."
- Active voice. Simple present, past or future tense. No "-ing" verb forms.
- Use "the", "a" and "an". No phrasal verbs, idioms, or metaphors.
- One topic per paragraph, 6 sentences or fewer. Prefer numbered steps and tables.
- Code identifiers, file paths, commands and product names are technical names. Keep them as they are, in `code`.

## 4. Choose the diagrams

Read `references/diagram-patterns.md`. Pick the form from the concept, not from habit:

| The concept is | Draw |
| --- | --- |
| steps in order, with decisions | flowchart |
| messages between parts over time | sequence diagram |
| a value or status that changes | state diagram |
| what contains or owns what | box (structure) diagram |
| a change from old to new | before / after panels |

One concept per diagram, 9 boxes or fewer. Labels use the same STE terms as the text. Most pages need one or two diagrams. Add a diagram only when it shows something the text cannot show as clearly.

If you have the `artifact-diagramming` skill, load it before you draw.

## 5. Check the text

Put the prose (not the HTML) in a temporary file and run:

```sh
<skill-dir>/scripts/ste-check draft.md
```

It reports long sentences, passive voice, "-ing" words and words from the avoid list, with line numbers. Fix each hit. You can keep a hit when it is a technical name or when the STE form reads worse; say why to yourself, not on the page. Run it again until it is clean or every hit left has a reason.

## 6. Build the page

Start from `references/page-template.html`. Keep its tokens and dark-mode rules. Fill the sections in this order and delete the ones that do not apply:

1. **Summary**: 2 or 3 sentences. What it is and why it matters.
2. **Terms**: a table, term to one-sentence definition.
3. **Diagrams**: each with a one-line caption that says what to look at.
4. **How it works**: numbered steps, one action per step.
5. **In the code**: a list of `path:line` with one line each. Only when the concept is in a repo.
6. **Check yourself**: 2 or 3 questions. Put each answer in a `<details>` element.

The page title is the concept in two to four words, for example "Request proxy flow".

## 7. Deliver

- **With an Artifact tool** (Claude Code): load the `artifact-design` skill, then publish the page. Reply with the link and the summary.
- **Without one** (Codex and other hosts): write the page to a temporary directory. Reply with the absolute path and the summary.

The page can hold code and file paths from a private repo. Publish it only as a private page. Do not send it to any other service.

## Offer after dense answers

This skill cannot start by itself. To get an offer after long answers, the user adds a standing instruction to their personal agent file (`~/.claude/CLAUDE.md` or `~/.codex/AGENTS.md`):

> After a long or dense answer (a plan, a review, an architecture or multi-file explanation), end with one line: "Run /explain last for an STE version with diagrams."

When that line is present, make the offer only after such answers, and only once per answer.
