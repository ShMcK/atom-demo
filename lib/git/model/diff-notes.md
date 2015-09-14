file path
.match(/^diff --git a[^\s]+/)[0].slice(12)
"/lib/tut-view.coffee"

diff changes
match(/^@@ (.+?(?= @@))/m)[0].slice(3)
"-1,6 +1,8"
