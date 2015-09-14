diff changes
match(/^@@ (.+?(?= @@))/m)[0].slice(3)
"-1,6 +1,8"

commit message
.split(/^@@ .+?(?= @@) @@ /m)[1]
