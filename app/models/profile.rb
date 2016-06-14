class Profile < ActiveRecord::Base
  belongs_to :member

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :postal_code
end
