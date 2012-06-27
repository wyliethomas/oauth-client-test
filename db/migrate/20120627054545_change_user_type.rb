class ChangeUserType < ActiveRecord::Migration
  def up
    remove_column   :users,     :type
    add_column      :users,     :kind,        :string
  end

  def down
    remove_column   :users,     :kind
    add_column      :users,     :type,        :string
  end
end
