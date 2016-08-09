class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :location, index: true, foreign_key: true
      t.string :caption
      t.attachment :image

      t.timestamps null: false
    end
  end
end
