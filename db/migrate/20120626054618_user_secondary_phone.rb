class UserSecondaryPhone < ActiveRecord::Migration
  def up
    add_column :users,            :phoneSecondary,            :string
  end

  def down
    remove_column :users,         :phoneSecondary
  end
end
