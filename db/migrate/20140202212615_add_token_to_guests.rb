class AddTokenToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :token, :string
  end
end
