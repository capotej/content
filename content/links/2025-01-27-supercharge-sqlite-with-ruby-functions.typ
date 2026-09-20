#let meta = (
  title: "Supercharge SQLite with Ruby Functions",
  date: "2025-01-27",
  url: "https://blog.julik.nl/2025/01/supercharge-sqlite-with-ruby-functions",
)
#context metadata((meta))

= Supercharge SQLite with Ruby Functions

An interesting twist in my recent usage of SQLite was the fact that I noticed my research scripts and the database intertwine more. SQLite is unique in that it really lives in-process, unlike standalone database servers. There is a feature to that which does not get used very frequently, but can be indispensable in some situations. By the way, the talk about the system that made me me to explore SQLite in anger can now be seen here. Normally it is your Ruby (or Python, or Go, or whatever) program which calls SQLite to make it “do stuff”. Most calls will be mapped to a native call like sqlite3\_exec() which will do “SQLite things” and return you a result, converted into data structures accessible to your runtime. But there is another possible direction here - SQLite can actually call your code instead.
