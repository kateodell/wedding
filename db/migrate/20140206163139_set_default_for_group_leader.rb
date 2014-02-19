class SetDefaultForGroupLeader < ActiveRecord::Migration
  def change
    change_column :guests, :group_leader, :integer
  end
end
