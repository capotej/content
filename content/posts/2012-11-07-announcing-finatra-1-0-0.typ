#let meta = (
  title: "Announcing Finatra 1.0.0",
  date: "2012-11-07",
  tags: ("finatra", "scala"),
  draft: false,
  redirect_from: "/blog/2012/11/07/announcing-finatra-1-0-0",
)
#context metadata((meta))

= Announcing Finatra 1.0.0

After months of work #link("https://github.com/capotej/finatra#readme")[Finatra] 1.0.0 is finally available! Finatra is a scala web framework inspired by #link("https://github.com/sinatra/sinatra#readme")[Sinatra] built on top of #link("http://twitter.github.com/finagle")[Finagle].

==== The API

The API looks like what you'd expect, here's a simple endpoint that uses route parameters:

```scala
get("/user/:username") { request =>
  val username = request.routeParams.getOrElse("username", "default_user")
  render.plain("hello " + username).toFuture
}
```

The `toFuture` call means that the response is actually a #link("http://twitter.github.com/scala_school/finagle.html#Future")[Future], a powerful concurrency abstraction worth checking out.

Testing it is just as easy:

```scala
"GET /user/foo" should "responds with hello foo" in {
  get("/user/foo")
  response.body should equal ("hello foo")
}
```

==== A super quick demo

```shell
$ git clone https://github.com/capotej/finatra.git
$ cd finatra
$ ./finatra new com.example.myapp /tmp
```

Now you have an `/tmp/myapp` you can use:

```shell
$ cd /tmp/myapp
$ mvn scala:run
```

A simple app should've started up locally on port 7070, verify with:

```shell
$ curl http://localhost:7070
hello world
```

You can see the rest of the endpoints at `/tmp/myapp/src/main/scala/com/example/myapp/App.scala`

==== Heroku integration

The generated apps work in heroku out of the box:

```shell
$ heroku create
$ git init
$ git add .
$ git commit -am 'stuff'
$ git push heroku master
```

Make sure to see the full details in the #link("https://github.com/capotej/finatra#readme")[README] and check out the #link("https://github.com/capotej/finatra-example")[example app].

Props to #link("http://twitter.com/twoism")[\@twoism] and #link("http://twitter.com/thisisfranklin")[\@thisisfranklin] for their code, feedback and moral support.
