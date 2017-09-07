# Ezopo (WARNING: WIP)
Yet another static site generator.

## Specifics
1. Engine is not aiming to be user-frinedly,
2. Engine generates ready HTML files, that one can use any way they want:
   1. GitHub Pages,
   2. Surge,
   3. Own server,
   4. Locally,
   5. etc.
3. Pages are written in `.md` files.

## Installation
I will make shard someday, for now just use `ezopo.cr`.

## Usage
Read more about usage in `usage.md` file.

## Example
Try it yourself! You'll need Crystal compiler. First, clone the repo:
```bash
git clone https://github.com/bouncepaw/ezopo.git
cd ezopo/example_wiki
```

Now write some `.md` files in `pages` directory. I wrote one for lazy people. Now compile and run `wiki.cr`:
```bash
crystal wiki.cr
```

Check `site` directory.

## Coming soon
1. Plugins
2. Shard
