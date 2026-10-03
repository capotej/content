// probe: can a .tmTheme be loaded from typst code and recolor code blocks?
#set raw(theme: read("catppuccin.tmTheme", encoding: none))

```ruby
def hello
  "world" if true
end
```
