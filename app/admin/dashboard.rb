ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Wikipedia Knowledge base" do
          ul do 
            li "Total Wikipedia pages: #{w_all = Page.count}"
            li "Imported Wikipedia pages: #{w_all = Page.has_html.count}"
            li "Not Imported Wikipedia pages: #{w_all = Page.has_no_html.count}"
          end
        end
      end

      column do
        panel "Dictionary Status" do
          para "Still being prepared"
        end
      end
    end
  end # content
end
