require 'open-uri'

module ContentGrabberHelper

  def self.get_content(page_title)
    url=wiki_url(page_title)
    open(URI.encode(url)).readlines.join
  end

  def self.wiki_url(page_title)
    "http://ar.wikipedia.org/w/index.php?title=#{page_title}&action=render"
  end

end
