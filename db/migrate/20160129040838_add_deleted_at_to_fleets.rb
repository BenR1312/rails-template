class AddDeletedAtToFleets < ActiveRecord::Migration
  def change
    add_column :fleets, :deleted_at, :datetime
    add_index :fleets, :deleted_at
  end
end
