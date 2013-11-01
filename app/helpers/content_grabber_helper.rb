require 'open-uri'

module ContentGrabberHelper

  def self.get_content(page_title)
    url="http://ar.wikipedia.org/w/index.php?title=#{page_title}&action=render"
    open(URI.encode(url)).readlines.join
  end

end
