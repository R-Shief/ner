ActiveAdmin.register Page do

  filter :page_title
  filter :page_namespace
  filter :page_is_redirect
  filter :page_is_new
  filter :with_html_content
  # filter :has_html , :as => :select
  # filter :imported, :label => 'Imported', :as => :select, :collection => [['any', nil], ['yes', true],['no', false]]
  scope :all, :show_count => false
  scope "imported", :has_html
  scope "not imported", :has_no_html

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

    # scope :all 
    # scope :has_html {|pages| pages.where("html is not null")}
    # scope :has_no_html {|pages| pages.where(html: nil)}
  end



  member_action :import, :method => :put do
    page = Page.find(params[:id])
    r=page.update_attributes(html: ContentGrabberHelper.get_content(page.page_title))
    redirect_to action: :index, notice: (r ? "imported" : "failed to import")
    # user = User.find(params[:id])
    # user.lock!
    # redirect_to {:action => :show}, {:notice => "Locked!"}
  end  
end
