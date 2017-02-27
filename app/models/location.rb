class Location < ActiveRecord::Base

  belongs_to :member
  has_many :pictures, dependent: :destroy
  has_many :reservations
  has_many :available_dates

  geocoded_by :full_street_address
  after_validation :geocode, if: -> (obj) { obj.address_1.present? and obj.address_changed? }

  LOC_TYPES = %w(Room Apartment House)

  validates :loc_type, inclusion: { in: LOC_TYPES, message: "is not an appropriate type" }
  validates :name, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, format: { with: /\A\d{5}(?:-\d{4})?\z/ }
  validates :occupancy, numericality: { only_integer: true, message: "must be a whole number greater than zero" }
  validates :occupancy, numericality: { greater_than: 0, message: "must be a whole number greater than zero" }

  scope :not_mine, ->(user) { where("member_id != ?", user) }

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
