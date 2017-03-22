class Location < ActiveRecord::Base

  belongs_to :member
  has_many :pictures, dependent: :destroy
  has_many :reservations
  has_many :available_dates

  geocoded_by :full_street_address
  after_validation :geocode, if: -> (obj) { obj.address_1.present? and obj.address_changed? }

  LAKES = %w(Conesus Hemlock Canadice Honeoye Canandaigua Keuka Seneca Cayuga Owasco Skaneateles Otisco)
  LOC_TYPES = %w(Room Apartment Condo House)

  validates :name, presence: true
  validates :nearest_lake, inclusion: { in: LAKES, message: "is not a Finger Lake"}
  validates :loc_type, inclusion: { in: LOC_TYPES, message: "is not an appropriate type" }
  validates :occupancy, numericality: { only_integer: true, message: "must be a whole number greater than zero" }
  validates :occupancy, numericality: { greater_than: 0, message: "must be a whole number greater than zero" }
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, format: { with: /\A\d{5}(?:-\d{4})?\z/ }

  scope :not_mine, ->(user) { where("member_id != ?", user) }
  scope :near_lake, ->(lake) { where("nearest_lake = ?", lake) }
  scope :with_available_dates, ->(date_range_array) {
    joins(:available_dates).
    merge(AvailableDate.
    available_for_reservation(date_range_array)) if date_range_array.present?
  }

  def available?(date)
    !self.available_dates.where(available_date: date).empty?
  end

  def address_changed?
    address_1_changed? || city_changed? || state_changed?
  end

  def full_street_address
    [address_1, city, state, "US"].compact.join(', ')
  end

  def name_and_area
    name + ' ' + csz
  end

  def csz
    [[city, state].join(', '), postal_code].join(' ')
  end

end
