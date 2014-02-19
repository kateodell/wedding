class AddNotesToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :dietary_notes, :text
    add_column :guests, :other_notes, :text
  end
end
