ActiveAdmin.register Guest do
    index do
        column :email
        column :first_name
        column :last_name
        column :rehearsal_status
        column :rsvp_status
        column :group_leader
        column :token
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
        end
        f.actions
      end
      controller do
        def permitted_params
          params.permit guest: [:email, :first_name, :last_name, :group_leader, :phone, :mailing_address, :city, :state, :zip]
        end
      end

      active_admin_importable
end