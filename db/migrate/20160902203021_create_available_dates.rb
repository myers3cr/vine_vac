class CreateAvailableDates < ActiveRecord::Migration
  def change
    create_table :available_dates do |t|
      t.references :location, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true
      t.date :available_date
      t.integer :status
      t.monetize :price

      t.timestamps null: false
    end
  end
end
