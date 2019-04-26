class AddUserIdToShops < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM shops;'
    add_reference :shops, :user, null: false, index: true
  end

  def down
    remove_reference :shops, :user, index: true
  end
end
