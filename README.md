# Vikiilo (WARNING: WIP)
Yet another wiki engine (I think so).

## Specifics
1. Engine is not aiming to be user-frinedly,
2. Engine generates ready HTML files, that one can use any way they want:
   1. GitHub Pages,
   2. Own server,
   3. Locally,
   4. etc.
3. Pages are written in `.md` files.

## Installation
I will make shard someday, for now just use `vikiilo.cr`.

## Usage
Read more about usage in `usage.md` file.

## Example
Try it yourself! You'll need Crystal compiler. First, clone the repo:
```bash
git clone https://github.com/bouncepaw/vikiilo.git
cd vikiilo/example_wiki
```

Now write some `.md` files in `pages` directory. I wrote one for lazy people. Now compile and run `wiki.cr`:
```bash
crystal wiki.cr
```

Check `site` directory.

## Coming soon
1. Plugins
2. Themes
3. Shard
