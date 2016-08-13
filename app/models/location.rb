class Location < ActiveRecord::Base
  
  belongs_to :member
  has_many :pictures, dependent: :destroy

  geocoded_by :full_street_address
  after_validation :geocode, if: -> (obj) { obj.address_1.present? and obj.address_changed? }

  LOC_TYPES = %w(Room Apartment House)

  validates :loc_type, 
    inclusion: { in: LOC_TYPES, message: "%{value} is not an appropriate type" }
  validates :name, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code,
    format: { with: /\A\d{5}(?:-\d{4})?\z/ }

  def address_changed?
    address_1_changed? || city_changed? || state_changed?
  end

  def full_street_address
    [address_1, city, state, "US"].compact.join(', ')
  end

  def csz
    [[city, state].join(', '), postal_code].join(' ')
  end

end
