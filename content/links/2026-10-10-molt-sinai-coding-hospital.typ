#let meta = (
  title: "Five months treating bugs like patients and coding agents like a medical team",
  date: "2026-10-10",
  url: "https://www.cockroachlabs.com/blog/experiment-running-hospital-code/",
)

#context metadata((meta))

Cockroach Labs ran their MOLT migration tooling through a five-month "coding
hospital" — MOLT Sinai — where agents play Triage Nurses, Fellows, and Review
Attendings, issues are patients, and merging is discharge. The results are
the usual agent speed but with enterprise guardrails: a full IBM Db2
migration path shipped in under two days for \$4,172 in tokens (vs. 9 months
and ~\$160K for Oracle in 2024), a million-plus lines of code processed with
just 7 reverts, and test coverage equivalent to their best-tested dialect.
The interesting part is the org design: planning reviews before code,
mandatory record-keeping, and escalation paths to human "Chiefs of Medicine"
— throughput optimized for trust, not speed.
