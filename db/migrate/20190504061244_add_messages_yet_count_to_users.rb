class AddMessagesYetCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :messages_yet_count, :integer, default: 0
  end
end
