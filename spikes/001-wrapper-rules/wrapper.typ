// Spike 001: does an outer wrapper's set/show rules reach #included content
// in HTML export, and can typst own code colors via a .tmTheme?
#set text(font: "Georgia", size: 12pt, fill: rgb("#222222"))

#show heading: it => {
  block(above: 1.4em, below: 0.6em)[
    #text(fill: rgb("#0a58ca"), weight: "bold", it.body)
  ]
}

// code blocks: dark background, light text, syntax theme recolors tokens
#show raw.where(block: true): it => block(
  fill: rgb("#1e1e2e"),
  inset: 10pt,
  radius: 6pt,
  text(fill: rgb("#cdd6f4"), it),
)

#include "/content/posts/2008-09-27-highlight-link-based-on-current-page-in-rails.typ"
