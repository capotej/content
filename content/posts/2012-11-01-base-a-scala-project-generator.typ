#let meta = (
  title: "Base: A Scala Project Generator",
  date: "2012-11-01",
  tags: ("efficiency", "scala", "shell-scripting"),
  draft: false,
  redirect_from: "/blog/2012/11/01/base-a-scala-project-generator",
)
#context metadata((meta))

= Base: A Scala Project Generator

Finally got tired of copy pasting other projects and gutting them to make new ones, so I created #link("http://github.com/capotej/base")[base], a shell command that creates new scala projects.

Creating the project:

```shell
$ base new com.capotej.newproj
creating project: newproj
  creating App.scala
  creating AppSpec.scala
  creating pom.xml
  creating .gitignore
  creating .travis.yml
  creating LICENSE
  creating README.markdown
Done! run mvn scala:run to run your project
```

Based on the package name, it inferred that the project name is `newproj` and created the project under that folder. Let's build and run it:

```shell
$ cd newproj
$ mvn compile scala:run
(... maven output ...)
hello world
```

This uses the new incremental compiler for maven, #link("http://github.com/typesafehub/zinc")[zinc], which dramatically speeds up compile times (except for the first time you run it). It also sets you up with the latest scalatest maven plugin, which gives you sweet looking test output, like so:

#html.elem("img", attrs: (src: "/assets/2012-11-01-base.png"))

See the base #link("http://github.com/capotej/base#readme")[README] for installation instructions.
