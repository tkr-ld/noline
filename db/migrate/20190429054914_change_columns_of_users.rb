class ChangeColumnsOfUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :name,:string, null: true
    change_column :users, :email,:string, null: true
    change_column :users, :password_digest,:string, null: true
  end

  def down
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
    change_column :users, :password_digest, :string, null: false
  end
end
