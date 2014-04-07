ActiveAdmin.register Guest do
    index do
        column :id
        column :email
        column :first_name
        column :last_name
        column :friday_rsvp
        column :saturday_rsvp
        column :group_leader
        column :token
        column :last_invite_emailed
        default_actions
      end

      filter :email

      form do |f|
        f.inputs "Guest Details" do
          f.input :email
          f.input :first_name
          f.input :last_name
          f.input :phone
          f.input :mailing_address
          f.input :city
          f.input :state
          f.input :zip
          f.input :group_leader, as: :select, collection: Guest.select(:group_leader == nil, :id, :first_name).to_a.map{|guest| guest.id}
          f.input :dietary_notes
          f.input :other_notes
          f.input :friday_rsvp, as: :select, collection: [Guest::RSVP_EMPTY, Guest::RSVP_NO, Guest::RSVP_MAYBE, Guest::RSVP_YES]
          f.input :saturday_rsvp, as: :select, collection: [Guest::RSVP_EMPTY, Guest::RSVP_NO, Guest::RSVP_MAYBE, Guest::RSVP_YES]
        end
        f.actions
      end
      controller do
        def permitted_params
          params.permit guest: [:email, :first_name, :last_name, :group_leader, :phone, :mailing_address, :city, :state, :zip, :dietary_notes, :other_notes, :saturday_rsvp, :friday_rsvp]
        end
      end

      active_admin_importable
end
