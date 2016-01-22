class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :truck_models do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    create_table :trucks do |t|
      t.string :registration, null: false
      t.belongs_to :truck_model, index: true, foreign_key: true
      t.belongs_to :driver, index: true
      t.datetime :scheduled_maintenance

      t.timestamps null: false
    end
  end
end
