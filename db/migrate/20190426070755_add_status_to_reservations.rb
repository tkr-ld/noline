class AddStatusToReservations < ActiveRecord::Migration[5.2]
  def up
    add_column :reservations, :status, :integer
    change_column :reservations, :status, :integer, {null: false}
    change_column :reservations, :status, :integer, {default: 0}
  end

  def down
    remove_column :reservations, :status
  end
end
