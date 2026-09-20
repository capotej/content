#let meta = (
  title: "The first thing I've been adding to AGENTS.md",
  date: "2026-06-01",
  tags: ("agents", "ai"),
  draft: false,
  redirect_from: "/blog/2026/06/01/the-first-thing-i-ve-been-adding-to-agents-md",
)
#context metadata((meta))

= The first thing I've been adding to AGENTS.md

My projects these days will usually begin with an `AGENTS.md` file where I'll define the stack of linters and context required for an agent to successfully stumble onto a working solution (most of the time, anyway).

But lately, I've been starting with just the following snippet:

```
## RFCs

Significant changes, architectural decisions, and new features should be proposed as RFCs in the `rfcs/` directory. RFCs use the format `rfcs/YYYY-MM-DD_short_title.md` with the following structure:

- `# Title` — short descriptive title
- `**Date:**` — proposal date (ISO format)
- `**Status:**` — `Proposed`, `Accepted`, `Implemented`, or `Rejected`
- `## Goal` — what the RFC aims to accomplish
- Remaining sections are free-form but typically include motivation, technical details, migration notes, and an implementation checklist
- When moving an RFC to `Implemented`, update `AGENTS.md` and `README.md` to reflect any new infrastructure, commands, or workflows introduced by the RFC
```

Then in a fresh session I'll prompt:

#quote(block: true)[
"Let's create a new RFC to _insert goal here_. Ask me any questions to disambiguate the plan"
]

(I'd imagine #link("https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md")[grill-me] would work well here too).

After some back and fourth we have a `Proposed` RFC pushed up as a Pull Request.

What I like about pushing up just the RFC is that we can discuss/socialize the plan before costly time and tokens are spent pursuing a non-obvious architectural dead-end. This is exactly how the real #link("https://en.wikipedia.org/wiki/Request_for_Comments")[RFC process works].

Another benefit is once the RFC is moved to `Implemented`, the RFC stays within the repository forever, effectively turning them into a free #link("https://github.com/architecture-decision-record/architecture-decision-record")[Architecture Decision Record] (this is why the date in the filename matters).

I've already noticed my agents save research time (and tokens) while also avoiding repeat design mistakes by leveraging previously `Implemented` RFCs.
