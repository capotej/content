#let meta = (
  title: "What I released in 2010",
  date: "2010-12-31",
  tags: (),
  draft: false,
  redirect_from: "/blog/2010/12/31/what-i-released-in-2010",
)
#context metadata((meta))

= What I released in 2010

Here’s a recap of what I’ve worked on and released in 2010:

==== #link("https://github.com/capotej/youtube_fraiche")[Youtube Fraiche]

I couldn’t find a youtube downloader that worked on github, so I wrote my own one evening

==== #link("https://github.com/capotej/uploadd")[Uploadd] and #link("https://github.com/capotej/paperclip_uploadd")[paperclip\_uploadd]

I wanted to upload and store images off-site (using paperclip/rails) on an server which has cheaper bandwidth rates than S3. Using rainbows, this tiny rack script has handled over a 1.5 million uploads at a peak of 10-15 uploads/sec. Also, it’s been running for about 6 months now without a single crash. Thank you Eric Wong! There is also a plugin for the popular paperclip gem to use uploadd as a storage backend transparently.

==== #link(
  "https://github.com/capotej/mrskinner/blob/master/mrskinner.js",
)[mrskinner]

Tiny javascript for making the site gutters clickable based on a fixed width layout

==== #link("https://github.com/capotej/existential")[existential]

Completely inspired by Nick Kallen’s #link("http://pivotallabs.com/users/nick/blog/articles/272-access-control-permissions-in-rails")[post] on authorization, I wanted to extract that pattern into a rails plugin that I could use for all my projects. I use devise/existential for all my projects now.

==== #link("https://github.com/capotej/has_opengraph")[has\_opengraph]

Easy way to participate in opengraph and draw facebook like buttons. Just annotate your models with meta data, and draw it in your view easily.

==== #link("https://github.com/capotej/chewbacca")[chewbacca]

I kinda feel bad that I took a cool name for such a lame script. Anyway it’s a set of rake tasks that provide a hair of abstraction above scp. Useful when you have a set of files locally that map to a different set of files remotely.

I already have tons of stuff in the works for 2011!
