# Vikiilo version 0.9.0 by bouncepaw <bouncepaw2@yandex.ru>
require "markdown"

module Vikiilo

  # parses all pages, the grand-magician of vikiilo
  def self.basic
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

  # pass a page name as `title`, and it will make a layout with `<title>` tag
  def self.gen_layout(title : String) : Array
    layout = File.read("layout.html").split("$$$")
    layout = layout[0] + title + layout[1], layout[2]
    layout
  end

  # glues layout and the page itself
  def self.gen_page(page_name : String, page : String) : String
    layout = self.gen_layout page_name
    layout[0] + Markdown.to_html(page) + layout[1]
  end
end
