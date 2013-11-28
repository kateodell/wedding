ActiveAdmin.register Guest do
    index do
        column :email
        column :first_name
        column :last_name
        column :rsvp_status
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
        end
        f.actions
      end
      controller do
        def permitted_params
          params.permit guest: [:email, :first_name, :last_name]
        end
      end
end