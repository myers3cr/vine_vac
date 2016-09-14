class AvailableDate < ActiveRecord::Base
  belongs_to :member
  belongs_to :location
  monetize :price_cents
  enum status: [ :available, :held, :reserved ]

  validates :location_id, presence: true
  validates :status, presence: true
  validates :available_date, presence: true

  def hold_for_member(member)
    update(status: :held, member: member)
  end

end