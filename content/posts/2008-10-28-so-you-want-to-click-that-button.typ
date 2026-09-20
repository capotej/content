#let meta = (
  title: "So you want to click that button?",
  date: "2008-10-28",
  tags: (),
  draft: false,
  redirect_from: "/blog/2008/10/28/so-you-want-to-click-that-button",
)
#context metadata((meta))

= So you want to click that button?

I stumbled upon#link("http://clickthatbutton.com")[http:\/\/clickthatbutton.com] during my routine lurking of#link("http://news.ycombinator.com")[hacker news] . After being amused for about 10 seconds, I decided to take it to the next level; I wanted to click on it really, really fast. After going through a few solutions (simple js while loop in firebug, then curl/wget) and failing, the idea of using selenium popped into my head. So I went off to their#link("http://selenium-ide.openqa.org/download.jsp")[site] and installed the extension. I figured a simple recording of the mouse event, then wrapping it around a loop in selenium would do the trick, but I quickly found that selenium doesn’t support loops. Not to be stopped, I searched google and ended up with#link("http://51elliot.blogspot.com/2008/02/selenium-ide-goto.html")[this] . After installing the plugin for selenium (a plugin for a plugin!?) and restarting firefox, I tried it again and to my surprise it worked! The click counter was going up steadily on its own (18k clicks and counting). Here is my selenium test case for those of you following along:

```html
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://selenium-ide.openqa.org/profiles/test-case">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="selenium.base" href="http://clickthatbutton.com/" />
<title>haha</title>
</head>
<body>
<table cellpadding="1" cellspacing="1" border="1">
<thead>
<tr><td rowspan="1" colspan="3">haha</td></tr>
</thead><tbody>
<tr>
    <td>open</td>
    <td>/</td>
    <td></td>
</tr>
<tr>
    <td>store</td>
    <td>x</td>
    <td>1</td>
</tr>
<tr>
    <td>while</td>
    <td>storedVars['x'] == storedVars['x']</td>
    <td></td>
</tr>
<tr>
    <td>click</td>
    <td>submit</td>
    <td></td>
</tr>
<tr>
    <td>endWhile</td>
    <td></td>
    <td></td>
</tr>

</tbody></table>
</body>
</html>
```

Just paste that into a file, open it with selenium ide, hit play and you should be good to go.
