class AddCityStateZipToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :city, :string
    add_column :guests, :state, :string
    add_column :guests, :zip, :string
  end
end
