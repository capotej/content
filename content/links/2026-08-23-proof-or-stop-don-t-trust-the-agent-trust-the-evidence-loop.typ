#let meta = (
  title: "Proof-or-Stop:Don’t Trust the Agent, Trust the Evidence Loop Engineering for Verifiable Evidence-Gated Lifecycle Control",
  date: "2026-08-23",
  url: "https://arxiv.org/html/2607.14890v1",
)
#context metadata((meta))

= Proof-or-Stop:Don’t Trust the Agent, Trust the Evidence Loop Engineering for Verifiable Evidence-Gated Lifecycle Control

Autonomous coding agents increasingly execute multi-step software work. However, lifecycle states such as reviewed, tested, done, and ready-to-merge remain claims unless a downstream system can decide whether those claims are supported by current evidence. In this work, we present Proof-or-Stop Lifecycle Control, a method in which lifecycle transitions are admitted only when fresh, tracked-source-state-bound, mechanically verifiable evidence satisfies the relevant gate. The method instantiates an agent-as-claim lifecycle semantics: agent outputs may propose lifecycle claims, but do not themselves constitute lifecycle state. Here, “proof” is used operationally to mean gate-admissible evidence under a stated trust model, not a proof of semantic program correctness.
