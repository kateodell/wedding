class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
        t.integer :group_leader
    end
  end
end
