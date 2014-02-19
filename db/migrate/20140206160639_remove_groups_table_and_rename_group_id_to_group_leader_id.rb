class RemoveGroupsTableAndRenameGroupIdToGroupLeaderId < ActiveRecord::Migration
  def up
    drop_table :groups
    rename_column :guests, :group_id, :group_leader
  end

  def down
    create_table :groups do |t|
        t.integer :group_leader
    end
    rename_column :guests, :group_leader, :group_id
  end
end
