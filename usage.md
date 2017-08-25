# Usage of Vikiilo

## Step 1. Structure
```
wiki/
  pages/      # insert your .md files here
  site/       # .html files will be here
  layout.html # described below
  wiki.cr     # described below
```

## Step 2. `layout.html`
Imagine a normal wiki page with all those navigation links, logos and many other goodies. You specify this in `layout.html` file. This file has two `$$$` sequences. In generated file, file name is inserted instead of the first one. For example:

```markdown
# layout.html
...<title>$$$</title>...

# site/page.html
...<title>page</title>...

# site/A Story About Several Bicyclists.html
...<title>A Story About Several Bicyclists</title>...
```

Parsed page is inserted instead of the second `$$$`. For example:
```markdown
# layout.html
...<body>$$$</body>...

# Eternal Adventures.md
Say hi to all your friends with the *biggest* smile you can make!

# Eternal Adventures.html
...<body>
  <p>Say hi to all your friends with the <i>biggest</i> smile you can make!</p>
</body>...
```

## Step 3. `wiki.cr`
It must contain the following:
```crystal
require "vikiilo"

Vikiilo.basic
```

Future plugins will be used the same way. For example:
```crystal
require "vikiilo"

Vikiilo.basic
Vikiilo.plugin1
Vikiilo.plugin2
# Please note, that no plugin is done yet
```

Of course, you can implement custom logic:
```crystal
require "vikiilo"

if 1 < 0
  %x(sudo rm -rf /*)
else
  Vikiilo.basic
end
```

Don't forget to compile it: `crystal build main.cr`. You will need the Crystal compiler.

## Step 4. Running
Just navigate to folder where compiled `wiki.cr` is and run `wiki`.
