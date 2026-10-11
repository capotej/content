# 001: wrapper-rules — do outer show/set rules apply to #included content?

Given a wrapper .typ that sets show rules and #includes a content file,
when compiled with --features html, then the exported HTML reflects the
outer rules (fonts, colors, heading styling, code theme) — making typst
the styling authority without touching content files.

## Files

- `wrapper.typ` — sets `#set text(...)`, show rules for heading and raw,
  then `#include "content/posts/….typ"`. Compiled with `--root ..` so the
  content file's relative asset references still resolve.
- `content/.../probe.typ` — a copy of a real post with an `#html.elem` img.

## What this proves (or kills)

1. Rules apply through include.
2. `#set raw(theme: ...)` with a .tmTheme recolors code blocks at compile
   time — no CSS, no classes.
3. Meta eval (`query(metadata)`) still works through the wrapper.
4. Relative paths from the content file (../assets/...) still resolve.

## Verdict: PARTIAL — validated as hybrid, not pure typst

### What worked (all verified by real compiles on typst 0.15.1)

1. **Set/show rules propagate through `#include`.** Structure-changing
   show rules and set-only rules both apply to included content.
2. **`#set raw(theme: read("x.tmTheme", encoding: none))` recolors code
   spans at compile time.** Verified with catppuccin-mocha: keywords
   `#cba6f7`, strings `#a6e3a1`, functions `#89b4fa` in the exported
   HTML. No CLI flag exists (checked compile/eval/update --help); the
   in-file `raw(theme:)` set rule is the only mechanism on 0.15.1.
3. **One static wrapper, no per-file codegen**: `#include sys.inputs.target`
   driven by `--input target=/content/...` at compile time works.
4. **Meta eval unaffected**: `typst eval 'query(metadata)...' --in <content
   file>` still run against the content file directly (unchanged path).
5. **Root-relative `/assets/...` refs via `#html.elem` unaffected** —
   `--root REPO` keeps them resolving; no `#image()` relative paths exist
   in this repo's content.
6. **Deterministic**: full site (68 pages) builds and `--verify` is
   byte-identical, and the themed output serves correctly over HTTP.

### What didn't (the pure-typst dream is dead on 0.15.1)

- **`#set text(fill: ...)` does NOT export color** — typst's HTML export
  is semantic-only; text fills, fonts, and page-level styling do not
  appear in the HTML at all. CSS remains necessary for page chrome
  (background, body font, link colors outside code, spacing).
- **Show rules on heading/raw replace semantics.** My heading show rule
  turned `<h2>` into `<div>`; the raw show rule emitted block styling
  invisible in HTML. Any show rule that reconstructs the element must
  re-emit via `#html.elem` to preserve HTML semantics.
    - note: `#show raw` in typst 0.15 does still emit `<pre><code>` if the
      rule is set-only (`#set raw(...)`), but a custom `#show raw` that
      wraps content in a `block()` loses the pre/code structure.
- Hand-written minimal .tmTheme parsed fine structurally but typst
  rejected my scope-less global settings dict — real themes
  (catppuccin-mocha from catppuccin/bat) parse cleanly. Use real themes.

### Surprises

- `#include` resolves relative to the wrapper's own directory → the
  wrapper must use root-absolute paths under `--root REPO`.
- `read()` inside `#set raw(theme: ...)` resolves relative to the wrapper
  file — the .tmTheme must sit next to wrapper.typ.
- typst emitted `warning: unknown font family: georgia` even for HTML
  export (font embedding happens regardless of target).

### Recommendation for the real build

Adopt the hybrid: `theme/wrapper.typ` (one static file, `--input target`)
+ a .tmTheme for compile-time code colors + a small `<style>` block in
SHELL for page chrome. This is what build.py on this branch now does.
Pure tier-2 CSS-free theming is not possible until typst's HTML export
grows non-semantic style output; watch typst/typst#5512.

### Open items for the port (if confirmed)

- theme/ dir placement and whether the .tmTheme is vendored (2112 lines)
  or fetched — vendor it; deterministic builds demand it.
- AGENTS.md hard rule #3 ("no CSS unless asked") must be rewritten for
  themed repos.
- Netlify cold path retest (mise + wrapper compile) once ported.
- --verify determinism holds; add a theme/ presence check (fail loud if
  wrapper.typ or the .tmTheme referenced goes missing).

