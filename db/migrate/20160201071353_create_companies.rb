class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :country
      t.text :slogan
      t.string :banner_image
      t.string :logo

      t.timestamps null: false
    end
  end
end
