#let meta = (
  title: "A Guide to Undefined Behavior in C and C++, Part 1 – Embedded in Academia",
  date: "2025-03-18",
  url: "https://blog.regehr.org/archives/213",
)
#context metadata((meta))

= A Guide to Undefined Behavior in C and C++, Part 1 – Embedded in Academia

Programming languages typically make a distinction between normal program actions and erroneous actions. For Turing-complete languages we cannot reliably decide offline whether a program has the potential to execute an error; we have to just run it and see.
