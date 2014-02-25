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
        panel "Saturday RSVPS" do
          ul do
            li "YES: " + Guest.where(saturday_rsvp: 'yes').count.to_s
            li "NO: " + Guest.where(saturday_rsvp: 'no').count.to_s
            li "MAYBE: " + Guest.where(saturday_rsvp: 'maybe').count.to_s
            li "No Response: " + Guest.where(saturday_rsvp: nil).count.to_s
          end
        end
      end

      column do
        panel "Friday RSVPS" do
          ul do
            li "YES: " + Guest.where(friday_rsvp: 'yes').count.to_s
            li "NO: " + Guest.where(friday_rsvp: 'no').count.to_s
            li "MAYBE: " + Guest.where(friday_rsvp: 'maybe').count.to_s
            li "No Response: " + Guest.where(friday_rsvp: nil).count.to_s
          end
        end
      end
    end
  end # content
end
