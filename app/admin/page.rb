ActiveAdmin.register Page do

  filter :page_title
  filter :page_namespace
  filter :page_is_redirect
  filter :page_is_new

  index do
    column :page_title
    column :html_imported do |p|
      !p.html.nil?
    end
    column :on_wiki_pedia do |a|
      link_to "wiki link", ContentGrabberHelper.wiki_url(a.page_title), target: "_blank"
    end
    default_actions
    actions do |page|
      link_to "grab content", admin_page_import_path(page.id), :method => :put
    end

  end

  member_action :import, :method => :put do
    page = Page.find(params[:id])
    r=page.update_attributes(html: ContentGrabberHelper.get_content(page.page_title))
    render text: r ? "imported" : "failed: #{page.errors}"
    # user = User.find(params[:id])
    # user.lock!
    # redirect_to {:action => :show}, {:notice => "Locked!"}
  end  
end
