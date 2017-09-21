# Ezopo
Static site generator.

```crystal
require "ezopo"

Ezopo.basic     # markdown -> html
Ezopo.templates # Templates plugin
```

Read more about usage in `usage.md` file.

## Specifics
- Engine generates static `.html` files,
- Pages are written in `.md` files,
- Plugins are Crystal methods.

## Installation
Write this in `shards.yaml`:
```yaml
dependencies:
  ezopo:
    github: bouncepaw/ezopo
```

I haven't tested that yet actually :smile:

