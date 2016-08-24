class Reservation < ActiveRecord::Base
  belongs_to :location
  belongs_to :member

  validates :location_id, presence: true
  validates :member_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
end
