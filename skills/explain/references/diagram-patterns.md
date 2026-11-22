# Diagram patterns

A diagram earns its place when it shows a mechanism the reader would otherwise build in their head from the text: where data goes, which parts talk, what changes, what state a thing moves through. If one sentence says it faster, write the sentence.

## Pick the form

| The concept is | Form | Reads |
| --- | --- | --- |
| steps in order, with decisions | flowchart | top to bottom |
| messages between parts over time | sequence diagram | lifelines left to right, time top to bottom |
| a value or status that changes | state diagram | left to right |
| what contains or owns what | box (structure) diagram | nested boxes |
| a change from old to new | before / after panels | two panels side by side, the difference marked |

## Rules

- **Draw the mechanism, not its name.** A box labelled "cache" tells less than the path a request takes through it.
- **Label every arrow** with a verb: `sends`, `reads`, `returns 401`. An arrow with no label means "related somehow".
- **Use the same terms as the text.** A part called "proxy" in the steps is "proxy" in the diagram.
- **One claim per figure, 9 boxes or fewer.** Split a larger picture into two figures.
- **Mark one thing.** Use the accent colour (`var(--accent)`) only on the part the reader must look at: the new hop, the failing step, the changed edge.
- **Before / after must show the difference.** Draw the same parts in both panels and mark what was added or removed. Two unrelated pictures are not a comparison.
- **Short labels.** One to three words in a box. Explanations go in the caption.

## SVG mechanics

Hand-write inline `<svg>`: `rect`, `line`, `path`, `polyline`, `text`. No libraries, no external images, no `<script>`, `<style>` or `<foreignObject>` inside the SVG.

- Size with `viewBox="0 0 W H"` and let CSS scale it. Choose W and H for the content.
- Stroke and text in `currentColor`, so the diagram follows the light or dark theme. Fill boxes with `var(--surface)`.
- Arrowheads: a `<marker>` in the SVG's own `<defs>`, used with `marker-end="url(#arrow-N)"`. Give each SVG its own marker id, because ids are global on the page.
- Text at 12 to 13px of the drawn scale, `text-anchor="middle"` in boxes.
- Align to a grid: equal gaps, shared baselines.
- Wrap each SVG in `<figure>` with a `<figcaption>`. Give the SVG `role="img"` and an `aria-label` that states the same claim as the caption.

## Starter shapes

Box with a label (centre the text on the box):

```svg
<rect x="20" y="20" width="140" height="48" rx="8" class="box"/>
<text x="90" y="49" text-anchor="middle">Proxy</text>
```

Labelled arrow:

```svg
<defs>
  <marker id="arrow-1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
    <path d="M0,0 L10,5 L0,10 z" fill="currentColor"/>
  </marker>
</defs>
<line x1="160" y1="44" x2="260" y2="44" stroke="currentColor" marker-end="url(#arrow-1)"/>
<text x="210" y="36" text-anchor="middle" class="label">sends</text>
```

Decision (flowchart):

```svg
<path d="M90,100 L150,130 L90,160 L30,130 z" class="box"/>
<text x="90" y="134" text-anchor="middle">Valid?</text>
```

Sequence lifeline:

```svg
<text x="80" y="20" text-anchor="middle">Browser</text>
<line x1="80" y1="30" x2="80" y2="260" stroke="currentColor" stroke-dasharray="4 4" class="muted"/>
```

Highlighted part (the one thing to look at):

```svg
<rect x="20" y="20" width="140" height="48" rx="8" class="box accent"/>
```

The CSS classes `box`, `label`, `muted` and `accent` are defined in `page-template.html`.
