#let meta = (
  title: "Deadlock-free Mutexes and Directed Acyclic Graphs",
  date: "2025-04-04",
  url: "https://bertptrs.nl/2022/06/23/deadlock-free-mutexes-and-directed-acyclic-graphs.html",
)
#context metadata((meta))

= Deadlock-free Mutexes and Directed Acyclic Graphs

If you need to ensure that a particular piece of data is only ever modified by one thread at once, you need a mutex. If you need more than one mutex, you need to be wary of deadlocks. But what if I told you that there’s a trick to avoid ever reaching a deadlock at all? Just acquire them in the right order!
