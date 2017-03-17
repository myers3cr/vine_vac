class Reservation < ActiveRecord::Base

  belongs_to :location
  belongs_to :member

  validates :location_id, presence: true
  validates :member_id, presence: true
  validates :occupancy, numericality: { only_integer: true, message: "must be a whole number greater than zero" }
  validates :occupancy, numericality: { greater_than: 0, message: "must be a whole number greater than zero" }

  validate :start_date_today_or_after
  validate :end_date_after_start_date

  # validate :dates_are_available

private

  def start_date_today_or_after
    errors.add(:start_date, "can't be blank") unless start_date
    errors.add(:start_date, "must be today or later") unless
      start_date && ((DateTime.now.to_date - start_date) <= 0 )
  end

  def end_date_after_start_date
    errors.add(:end_date, "can't be blank") unless end_date
    errors.add(:end_date, "must be after start date") unless
      (start_date && end_date) && ((end_date - start_date) >= 1)
  end

  # def dates_are_available
  #   if (start_date && end_date)
  #     dates = start_date..(end_date - 1.day)
  #     availables = dates.map { |d| Location.find(location_id).available?(d) }
  #     errors.add(:start_date, "not all dates are available") unless availables.count(false) == 0
  #   end
  # end

end
