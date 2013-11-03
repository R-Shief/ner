ActiveAdmin.register Page do

  filter :title

  index do
    column :page_title
     # ["page_id", "page_namespace", "page_title", "page_restrictions", "page_counter", "page_is_redirect", "page_is_new", "page_random", "page_touched", "page_latest", "page_len", "page_no_title_convert"]
    # column link_to(p.page_title, "http://ar.wikipedia.org/w/index.php?title=#{p.page_title}&action=render", target: "_blank")
    default_actions
  end

  
end
