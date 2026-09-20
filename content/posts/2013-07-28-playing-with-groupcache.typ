#let meta = (
  title: "Playing with groupcache",
  date: "2013-07-28",
  tags: ("databases", "distributed-computing", "go"),
  draft: false,
  redirect_from: "/blog/2013/07/28/playing-with-groupcache",
)
#context metadata((meta))

= Playing with groupcache

This week, #link("http://twitter.com/bradfitz")[\@bradfitz] (of memcached fame) released #link("http://github.com/golang/groupcache")[groupcache] at OSCON 2013. I'm already a big fan of #link("http://memcached")[memcached] and #link("http://camlistore.org")[camlistore], so I couldn't wait to download it and kick the tires.

By the way, I *strongly* recommend you go through the #link("http://talks.golang.org/2013/oscon-dl.slide#1")[slides] and #link("http://github.com/golang/groupcache")[README] before going further.

=== What groupcache is not

After downloading it (without reading the #link("http://talks.golang.org/2013/oscon-dl.slide#1")[slides]), I instinctively searched around for how to actually start the server(s), only to find nothing. Turns out, groupcache is more of a _library_ with a server built in, rather than a traditional standalone server. Another important consideration is that theres *no support for set/update/evict operations*, all you get is GET. Really fast, consistent, distributed GET's.

=== What it is

Once you realize that groupcache is more of a *smart, distributed LRU cache*, rather than an outright memcached replacement, it all makes much more sense. Especially considering what it was built for, caching immutable file blobs for #link("http://dl.google.com")[dl.google.com].

=== How to use it

For groupcache to work, you have to give it a closure in which: given a `key`, fill up this `dest` buffer with the bytes for the value of that key, from however you store them. This could be hitting a database, a network filesystem, anything. Then you create a groupcache `group` object, which knows the addresses of all the other groupcache instances. This is pluggable, so you can imagine rigging that up to zookeeper or the like for automatic node discovery. Finally, you start groupcache up by using go's built in `net/http` and a `ServeHTP` provided by the previously constructed `group` object.

=== Running the demo

In order to really try out groupcache, I realized I needed to create a mini test infrastructure, consisting of a slow database, frontends, and a client. Visit the #link("http://github.com/capotej/groupcache-db-experiment")[Github Repo] for more details. This is what the topology looks like:

#html.elem("img", attrs: (src: "/assets/2013-07-28-groupcache-topology.png", alt: "groupcache topology"))

===== Setup

+ `git clone git@github.com:capotej/groupcache-db-experiment.git`

+ `cd groupcache-db-experiment`

+ `sh build.sh`

===== Start database server

+ `cd dbserver && ./dbserver`

===== Start Multiple Frontends

+ `cd frontend`

+ `./frontend -port 8001`

+ `./frontend -port 8002`

+ `./frontend -port 8003`

===== Use the CLI to play around

Let's set a value into the database:

```
./cli -set -key foo -value bar
```

Now get it out again to make sure it's there:

```
./cli -get -key foo
```

You should see `bar` as the response, after about a noticeable, 300ms lag.

Let's ask for the same value, via cache this time:

```
./cli -cget -key foo
```

You should see on one of the frontend's output, the key `foo` was requested, and in turn requested from the database. Let's get it again:

```
./cli -cget -key foo
```

You should have gotten this value instantly, as it was served from groupcache.

Here's where things get interesting; Request that same key from a different frontend:

```
./cli -port 9002 -cget -key foo
```

You should still see `bar` come back instantly, even though this particular groupcache node did not have this value. This is because groupcache knew that 9001 had this key, went to that node to fetch it, then cached it itself. *This is groupcache's killer feature*, as it avoids the common thundering herd issue associated with losing cache nodes.

===== Node failure

Let's simulate single node failure, find the "owner" of key `foo` (this is going to be the frontend that said "asking for foo from dbserver"), and kill it with Ctrl+C. Request the value again:

```
./cli -cget -key foo
```

It'll most likely hit the dbserver again (unless that particular frontend happens to have it), and cache the result on one of the other remaining frontends. As more clients ask for this value, it'll spread through the caches organically. When that server comes back up, it'll start receiving other keys to share, and so on. The fan out is explained in more detail on this #link("http://talks.golang.org/2013/oscon-dl.slide#47")[slide].

=== Conclusion / Use cases

Since there is no support (by design) for eviction or updates, groupcache is a really good fit with read heavy, immutable content. Some use cases:

- Someone like #link("http://github.com")[Github] using it to cache blobrefs from their file servers

- Large websites using it as a CDN (provided their assets were unique `logo-0492830483.png`)

- Backend for #link("http://en.wikipedia.org/wiki/Content-addressable_storage")[Content-addressable storage]

Definitely a clever tool to have in the distributed systems toolbox.

_Shout out to professors #link("http://twitter.com/jmhodges")[\@jmhodges] and #link("http://twitter.com/mrb_bk")[\@mrb\_bk] for proof reading this project and post_
