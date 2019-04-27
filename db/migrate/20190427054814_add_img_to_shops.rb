class AddImgToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :img, :string
  end
end
