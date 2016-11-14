class AddOccupancyToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :occupancy, :integer
  end
end
