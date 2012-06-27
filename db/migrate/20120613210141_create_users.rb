class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column  :firstName,               :string
      t.column  :lastName,                :string
      t.column  :email,                   :string
      t.column  :username,                :string
      t.column  :phone,                   :string
      t.column  :mobilePhone,             :string
      t.column  :uniqueId,                :string

      t.timestamps
    end
  end
end
