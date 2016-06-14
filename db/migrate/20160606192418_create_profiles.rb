class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :member, index: true, foreign_key: true
      t.string :profile_type
      t.string :first_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps null: false
    end
  end
end
