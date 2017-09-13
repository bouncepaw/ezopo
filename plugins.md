# Ezopo plugins
Ezopo uses dead simple plugin system, because life is too short for compicated things. This document covers both creating and usage of plugins.

## Creating a plugin
Each plugin in Ezopo is a Crystal method, which iterates over each file in a directory, does something in it.

Plugins are declared in `Ezopo` module. To create a plugin you need to know Crystal. Let's make a plugin for templates.

### 1. Idea
This plugin will implement templates, like in MediaWiki, but with no argument support (coming soon). Plugin will check each `.html` file in `site/` directory, and replace each `{{template_name}}` with contents of corresponding `.html` file in `templates/` directory. For example:
```markdown
# pages/Page.html before plugin
...{{example}}...
# templates/example.html
<b>This is template</b>
# pages/Page.html after plugin
...<b>This is template!</b>...
```

Parser will parse a page until there is no template used. Multiple templates can be used inside one page. Templates can be used inside each other.

### 2. Creating a method
In `ezopo.cr`, in `Ezopo` module I made this method:
```crystal
def self.templates
  puts "#{Time.now} Templates: Plugin started"

  templates_hash = self.gen_templates
  puts "#{Time.now} Templates: Generated templates_hash"

  Dir.foreach "pages" do |page_name|
    puts "#{Time.now} Templates: Processing #{page_name}"

    if File.extname page_name == "html"
      self.parse_templates File.read "pages/#{page_name}"
    end
  end

  puts "#{Time.now} Templates: plugin finished"
end
```

It makes the most of the work: logs, iterates files. Methods `Ezopo.gen_templates` and `Ezopo.parse_templates` generate templates and parse templates respectively. Let's code them:

*TODO*: finish it. regex, gsub and other hard things. that'll be spicy
