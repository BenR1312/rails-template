class CreateFleets < ActiveRecord::Migration
  def change
    create_table :fleets do |t|
      t.string :fleet_name, null: false

      t.timestamps null: false
    end

    create_table :fleet_trucks do |t|
      t.belongs_to :fleet, index: true
      t.belongs_to :truck, index: true
      t.string :status, null: false

      t.timestamps null: false
    end
  end
end
