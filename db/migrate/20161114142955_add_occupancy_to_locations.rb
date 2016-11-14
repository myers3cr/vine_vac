class AddOccupancyToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :occupancy, :integer
  end
end
