class AvailableDate < ActiveRecord::Base
  belongs_to :member
  belongs_to :location
  monetize :price_cents
  enum status: [ :available, :held, :reserved ]

  validates :location_id, presence: true
  validates :status, presence: true
  validates :available_date, presence: true

  scope :upcoming, -> { where("available_date >= ?", Date.today) }
  scope :unreserved, -> { where(status: 'available') }
  scope :available_for_reservation, ->(date_range_array) {
    upcoming.unreserved.where(available_date: date_range_array) if date_range_array.present?
  }

  def hold_for_member(member)
    update(status: :held, member: member)
  end

  def reserve_for_member(member)
    update(status: :reserved, member: member)
  end

  def release
    update(status: :available, member: nil)
  end

end
