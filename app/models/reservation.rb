class Reservation < ActiveRecord::Base
  belongs_to :location
  belongs_to :member

  validates :start_date, presence: true
  validates :end_date, presence: true
  
end
