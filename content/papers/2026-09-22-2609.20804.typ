#let meta = (
  title: "An Empirical Study of Harness Design for Coding Agents",
  date: "2026-09-22",
  arxiv_id: "2609.20804",
  pdf_url: "https://arxiv.org/pdf/2609.20804",
)
#context metadata((meta))

= An Empirical Study of Harness Design for Coding Agents

A component-level empirical study of coding-agent harnesses — holding the execution loop fixed while varying planning, action space, and context management across 176 matched settings on SWE-Bench Verified and Terminal-Bench 2.1. Standout findings: rule-based elision staged before LLM summarization is the most efficient context strategy, planning shifts from accuracy scaffold to cost saver as models strengthen, and bash-capable models do better with a bash-only interface than with predefined tools, at substantially lower cost.
