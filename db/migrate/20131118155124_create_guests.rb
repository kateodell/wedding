class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.integer :contact_preference
      t.string :mailing_address
      t.integer :group_id
      t.integer :rsvp_status
      t.integer :rehearsal_status

      t.timestamps
    end
  end
end
