class ChangeStatusColumnsToStrings < ActiveRecord::Migration
  def up
    add_column :guests, :friday_rsvp, :string
    add_column :guests, :saturday_rsvp, :string

    remove_column :guests, :rehearsal_status
    remove_column :guests, :rsvp_status
  end

  def down
    remove_column :guests, :friday_rsvp
    remove_column :guests, :saturday_rsvp

    add_column :guests, :rehearsal_status, :integer
    add_column :guests, :rsvp_status, :integer
  end
end
