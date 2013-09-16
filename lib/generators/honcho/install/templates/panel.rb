Honcho.register_page "Dashboard" do

  content :title => proc{ I18n.t("honcho.panel") } do
    nav :class => "top-bar hide-for-small", :id => "honcho_default_message" do
      ul :class => "title-area" do
        li :class => "name" do
          I18n.t("honcho.panel_to_welcome.welcome")
        end       
      end
      section :class => "top-bar-section" do
        ul :class => "right" do
                    
        end
      end
    end

end