class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code
      
      t.timestamps null: false
    end
  end
end
