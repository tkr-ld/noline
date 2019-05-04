class AddColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user, null: false, index: true
  end
end
