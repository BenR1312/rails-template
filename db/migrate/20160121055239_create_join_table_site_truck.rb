class CreateJoinTableSiteTruck < ActiveRecord::Migration
  def change
    create_join_table :sites, :trucks do |t|
      t.index [:site_id, :truck_id]
      t.index [:truck_id, :site_id]
    end
  end
end
