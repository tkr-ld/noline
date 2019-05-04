class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :content_type
      t.string :content

      t.timestamps
    end
  end
end
