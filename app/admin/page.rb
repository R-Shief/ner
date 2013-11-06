ActiveAdmin.register Page do

  filter :page_id
  filter :page_title
  filter :page_namespace
  filter :page_is_redirect
  filter :page_is_new
  filter :with_html_content
  filter :importing_status, as: :select, collection: Page.importing_statuses.collect{|k,v| [k,v]}
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

    actions do |page|
      raw(%Q(
          #{link_to( "Check on wikipedia", ContentGrabberHelper.wiki_url(page.page_title), target: "_blank")}
          #{link_to( "Import from wikipedia", admin_page_import_path(page.id), :method => :put)}
        ))
    end
  end

  show do
    div class: "first_panel" do
      attributes_table do
        row :page_id
        row :page_namespace
        row :page_title
        row :page_restrictions
        row :page_counter
        row :page_is_redirect
        row :page_is_new
        row :page_random
        row :page_touched
        row :page_latest
        row :page_len
        row :page_no_title_convert
        row :title
        row :raw_html do 
          page.html
        end
        row :html do 
          page.html.try :html_safe
        end

      end
    end
  end

   action_item :only => :show do
    link_to 'Import from wikipedia', admin_page_import_path(page.id), :method=>:put
  end


  member_action :import, :method => :put do
    page = Page.find(params[:id])
    r=page.update_attributes(html: ContentGrabberHelper.get_content(page.page_title))
    redirect_to :action=> :show, :id=>params[:id], notice: (r ? "imported" : "failed to import")
    # user = User.find(params[:id])
    # user.lock!
    # redirect_to {:action => :show}, {:notice => "Locked!"}
  end  
end
