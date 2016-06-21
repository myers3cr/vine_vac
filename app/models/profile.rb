class Profile < ActiveRecord::Base
  belongs_to :member

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address_1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :postal_code
  has_attached_file :profile_pic,
    styles: { small: "100x100" },
    default_url: "missing-image.jpeg"
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/
end
