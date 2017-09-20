# Ezoop version 0.9.0 by bouncepaw <bouncepaw2@ya.ru>
require "markdown"

module Ezopo

  # Basic plugin
  # Turns each .md file in pages/ into .html and puts it in site/
  def self.basic : Nil
    puts "#{Time.now} Current directory: #{Dir.current}"

    Dir.foreach "pages" do |page_name|
      begin
        puts "#{Time.now} Processing #{page_name}"

        page = File.read "pages/#{page_name}"
        page_name = page_name[0..-4]
        new_page_name = "site/#{page_name}.html"
        new_page = self.gen_page page_name, page

        puts "#{Time.now} Generated #{new_page_name}"
        File.write new_page_name, new_page

      rescue
        next
      end
    end
  end

  # Basic plugin helper
  # Pass a page name as `title`, and it will make a layout with `<title>` tag
  def self.gen_layout(title : String) : Array
    layout = File.read("layout.html").split("$$$")
    layout = layout[0] + title + layout[1], layout[2]
    layout
  end

  # Basic plugin helper
  # Glues layout and the page itself
  def self.gen_page(page_name : String, page : String) : String
    layout = self.gen_layout page_name
    layout[0] + Markdown.to_html(page) + layout[1]
  end



  # Templates plugin
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

  # Templates plugin helper
  # Creates templates hash, where key is template file name and
  # value is its content
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

  # Templates plugin helper
  # Reads the file. If found string that is equal to a key in `templates_hash`,
  # replaces it with corresponding value.
  #
  # Example:
  # Ezopo.parse_templates("Hello world!", {"world" => "Ezopo"})
  # => Hello Ezopo!
  def self.parse_templates(page : String, templates_hash : Hash(String, String))
    regex = Regex.new("(" + templates_hash.keys.join("|") + ")")
    page = page.gsub(regex, templates_hash)
    page
  end
end

