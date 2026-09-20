#let meta = (
  title: "Render image links directly inside Adium",
  date: "2011-09-13",
  tags: (),
  draft: false,
  redirect_from: "/blog/2011/09/13/render-image-links-directly-inside-adium",
)
#context metadata((meta))

= Render image links directly inside Adium

Last night I delightfully discovered that Adium Message Styles are just html, css, and javascript rendered inside a webview. The next natural step was to write something in it, so I wrote a Message Style that tries to render any image link directly inline the conversation (campfire style).

The code was written at midnight after a long day, so its not best. Basically, it's a setInterval that runs every 2.5 seconds that loops through all message elements, appending an img tag to the body of the message if an image link is detected. It also removes the processing class as to not reprocess the same messages.

Installation is simple, just download: (no longer available)

and extract into \~/Library/Adium 2.0/Message Styles (create if necessary). Then choose the TOP Stockholm theme (no idea why there are two entries), and close your chat window. It should be activated next time a chat window opens.
