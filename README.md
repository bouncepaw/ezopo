# Ezopo
Static site generator.

```crystal
require "ezopo"

Ezopo.basic     # markdown -> html
Ezopo.templates # Templates plugin
```

## Specifics
- Engine generates static `.html` files,
- Pages are written in `.md` files,
- Plugins are Crystal methods.

## Installation
Write this in `shard.yml`:
```yaml
dependencies:
  ezopo:
    github: bouncepaw/ezopo
```

I haven't tested that yet actually :smile:

