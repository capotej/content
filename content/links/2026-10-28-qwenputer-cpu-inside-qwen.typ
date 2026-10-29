#let meta = (
  title: "Qwenputer: a fully functioning, deterministic RISC-V CPU inside Qwen3.5",
  date: "2026-10-28",
  url: "https://divagr.com/blog/qwenputer",
)
#context metadata((meta))

= Qwenputer: a fully functioning, deterministic RISC-V CPU inside Qwen3.5

A RISC-V RV32IM CPU compiled directly into the weights of stock Qwen 3.5 4B, using the model's Gated DeltaNet layers as exact RAM (gate = 1, write strength = 1, one-hot addressing) — no training, no plugins, no external tool calls. The CPU runs C and MicroPython inside the model's forward passes, matches qemu, has free-run 18 million instructions without error, and beats giving base Qwen a Python tool on most arithmetic benchmarks.
