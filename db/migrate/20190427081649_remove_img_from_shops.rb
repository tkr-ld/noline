class RemoveImgFromShops < ActiveRecord::Migration[5.2]
  def up
    remove_column :shops, :img
  end

  def down
    add_column :shops, :img, :string
  end
end
