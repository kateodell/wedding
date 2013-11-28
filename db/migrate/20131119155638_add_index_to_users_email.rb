class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :guests, :email
  end
end
