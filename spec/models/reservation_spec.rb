require 'rails_helper'

describe Reservation, type: :model do

  let(:reservation) { FactoryGirl.build(:reservation) }

  it "has a valid factory" do
    expect(reservation).to be_valid
  end

  it "is invalid without a start_date" do
    reservation.start_date = nil
    expect(reservation).to be_invalid
    expect(reservation.errors[:start_date]).to include("can't be blank")
  end
    
  it "is invalid without an end_date" do
    reservation.end_date = nil
    expect(reservation).to be_invalid
    expect(reservation.errors[:end_date]).to include("can't be blank")
  end

end