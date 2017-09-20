# Ezopo plugins
Ezopo uses dead simple plugin system, because life is too short for compicated things. This document covers both creating and usage of plugins.

## Creating a plugin
Each plugin in Ezopo is a Crystal method, which iterates over each file in a directory and does something in it.

Plugins are declared in `Ezopo` module. To create a plugin you need to know Crystal. Let's make a plugin for templates.

### 1. Idea
1. In `templates/` user creates any text files. Its name is template's name and its content is template's content.
2. Plugin generates a hash where keys are filenames and values are their contents.
3. Plugin replaces every template's name in page with its content.

For example, we have this templates hash:
```crystal
{
  "hello" => "good day",
  "ld" => "dl"
}
```

And page `test.md`:
```markdown
Hello, hello to the wonderful world!
```

After parsing by `Basic` plugin and after parsing by `Templates` plugin (the one I am describing right now), file turns to:
```html
...<p>Hello, good day to the wonderful wordl!</p>...
```

### 2. Coding
I made three methods in module `Ezopo`:

`Ezopo.templates` is the main:
```crystal
def self.templates : Nil
  puts "#{Time.now} Templates: Plugin started"

  templates_hash = self.gen_templates
  puts "#{Time.now} Templates: Generated templates_hash"

  Dir.foreach "site" do |filename|
    begin
      puts "#{Time.now} Templates: Processing #{filename}"
      File.write("site/#{filename}",
        self.parse_templates(
          File.read("site/#{filename}"), templates_hash))
    rescue
      puts "#{Time.now} Templates: something is wrong with #{filename}, next"
    end
  end

  puts "#{Time.now} Templates: Plugin finished"
end
```

`Ezopo.gen_templates` generates templates hash:
```crystal
def self.gen_templates()
  puts "#{Time.now} Templates: gen_templates() started"
  templates_hash = {} of String => String

  Dir.foreach "templates" do |filename|
    begin
      puts "#{Time.now} Templates: gen_templates() processing #{filename}"
      templates_hash[filename] = File.read("templates/#{filename}").chomp
    rescue
      puts "#{Time.now} Templates: gen_templates() something is wrong" +
        "with #{filename}, next"
    end
  end

  templates_hash
end
```

`Ezopo.parse_templates` simply parses the page:
```crystal
def self.parse_templates(page : String, templates_hash : Hash(String, String))
  regex = Regex.new("(" + templates_hash.keys.join("|") + ")")
  page = page.gsub(regex, templates_hash)
  page
end
```

### 3. Usage
This plugin should be used after `Basic` plugin:
```crystal
# somewhere in hard-to-understand crystal code
Ezopo.basic     # markdown -> html
Ezopo.templates # parses templates
```
