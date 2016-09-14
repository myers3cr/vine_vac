class Reservation < ActiveRecord::Base

  belongs_to :location
  belongs_to :member

  validates :location_id, presence: true
  validates :member_id, presence: true

  validate :start_date_today_or_after
  validate :end_date_after_start_date
  
private
  
  def start_date_today_or_after
    errors.add(:start_date, "can't be blank") unless start_date
    errors.add(:start_date, "must be today or after") unless start_date && ((DateTime.now.to_date - start_date) <= 0 )
  end

  def end_date_after_start_date
    errors.add(:end_date, "can't be blank") unless end_date
    errors.add(:end_date, "must be after start date") unless (start_date && end_date) && ((end_date - start_date) >= 1)
  end

end