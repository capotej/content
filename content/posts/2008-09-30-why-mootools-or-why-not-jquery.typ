#let meta = (
  title: "Why MooTools (or Why not JQuery)",
  date: "2008-09-30",
  tags: (),
  draft: false,
  redirect_from: "/blog/2008/09/30/why-mootools-or-why-not-jquery",
)
#context metadata((meta))

= Why MooTools (or Why not JQuery)

I’ve been toying around with MooTools a bit lately, and I’ve found the experience quite enjoyable and refreshing. Naturally, I #link("http://twitter.com/capotej/statuses/939831956")[twittered] about it and went along my merry way. Moments later (and much to my surprise), I had a direct message from John Resig himself asking “Why, what’s wrong with jQuery?”. I was pretty taken aback that he would take time from his surely busy day to message a total stranger in an effort to improve his project or at least gain an insight in the everyday life of a js developer (it’s not like DHH would personally message people that are dumping rails to use merb). I figured he deserved a straight, honest answer; One that at least would be longer than #link("http://twitter.com/capotej/statuses/940082809")[140 characters] (even though I managed to use every single one). So it begs the question, Why MooTools?

- Class support. JQuery’s SQL-like syntax is fine for quick and dirty javascripting, but eventually you’ll want real classes to structure your UI logic.

- It smells, feels and tastes like regular javascript. JQuery doesn’t even look like javascript, which isn’t necessarily a bad thing, since that’s kind of their goal. MooTools however, feels like just an extension of the language

- Faster. #link("http://mootools.net/slickspeed/")[‘Nuff Said] EDIT: This was pointed out to be false; It is only faster in certain cases (such as mine, WebKit nightly on OS X).

- Robert Penner’s easing equations baked right in.This could just be me, but I find the animations that mootools creates are alot smoother than JQuery’s (especially the easing).

- Creating new DOM elements is a snap.Need to create a dom element? `var el = new Element(‘a’, { ‘href’: ‘juliocapote.com’});` Done.

- Modular. I like that I can just build and pull down a moo.js that only contains the functionality I need.

- Better Documented.Or at least, its faster to find what you need.

- Easier to hack on and extend. While I haven’t personally delved into the internals of either system, the consensus seems to be that jquery is an unintelligible mess when it comes to modifying how it works.

- Prototype Approach (versus a namespaced approach) This is really just matter of preference; MooTools achieves it’s magic by just extending the prototypes of common objects (Array, String, etc); While this is obstrusive, it makes for shorter, more natural code. JQuery does its thing via a main object (which you can name, hence the namespace), that you wrap around whatever you want to make magical; This is unobtrusive, but you pay for that by having to wrap anything you want to use (which ends up being everything). It basically boils down to arr.each(fn) vs \$.each(arr, fn)

- It’s not a revolution. It feels as if JQuery is trying to take on the world (it seems like it too, since its now included with visual studio and the nokia sdk). However, I’m not; I’m just trying to write some javascript here.

It’s not like I’m never going to use JQuery again; It simply isn’t my default js framework any longer.
