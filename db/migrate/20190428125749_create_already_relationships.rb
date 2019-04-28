class CreateAlreadyRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :already_relationships do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
