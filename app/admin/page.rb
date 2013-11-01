ActiveAdmin.register Page do

  filter :title

  index do
    column :page_title
    # column link_to(p.page_title, "http://ar.wikipedia.org/w/index.php?title=#{p.page_title}&action=render", target: "_blank")
    default_actions
  end

  
end
