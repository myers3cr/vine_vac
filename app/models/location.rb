class Location < ActiveRecord::Base
  
  belongs_to :member

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :address_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :postal_code

  def csz
    [[city, state].join(', '), postal_code].join(' ')
  end

end
