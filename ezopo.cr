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

    Dir.foreach "pages" do |page_name|
      puts "#{Time.now} Templates: Processing #{page_name}"

      if File.extname page_name == "html"
        self.parse_templates(File.read "pages/#{page_name}", templates_hash)
      end
    end

    puts "#{Time.now} Templates: plugin finished"
  end

  # Templates plugin helper
  # Creates templates hash, where key is template file name and value is its
  # HTML contents
  def self.gen_templates : Hash
    templates_hash = {} of String => String

    Dir.foreach "templates" do |filename|
      begin
        templates_hash[File.basename(filename, ".html")] = File.read filename
      rescue
        next
      end
    end
  end

  # Templates plugin helper
  # Replaces all {{mustaches}} with corresponding template in `templates_hash`
  def self.parse_templates(page : String, templates_hash : Hash) : Nil
    # magic will be here
  end
end
