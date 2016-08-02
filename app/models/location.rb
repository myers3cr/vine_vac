class Location < ActiveRecord::Base
  
  belongs_to :member
  has_one :gallery

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

  def csz
    [[city, state].join(', '), postal_code].join(' ')
  end

end
