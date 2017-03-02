class AddNearestLakeToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :nearest_lake, :string
  end
end
