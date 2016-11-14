require 'rails_helper'

describe Reservation, type: :model do

  let(:reservation) { FactoryGirl.build(:available_reservation) }

  it "has a valid factory" do
    expect(reservation).to be_valid
  end

  it "is invalid without a location id" do
    reservation.location_id = nil
    expect(reservation).to be_invalid
    expect(reservation.errors[:location_id]).to include("can't be blank")
  end

  it "is invalid without a member id" do
    reservation.member_id = nil
    expect(reservation).to be_invalid
    expect(reservation.errors[:member_id]).to include("can't be blank")
  end
 
  it "is invalid without an appropriate occupancy" do
    reservation.occupancy = nil
    expect(reservation).to be_invalid
    expect(reservation.errors[:occupancy]).to include("must be a whole number greater than zero")
    reservation.occupancy = -1
    expect(reservation).to be_invalid
    expect(reservation.errors[:occupancy]).to include("must be a whole number greater than zero")
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

  it "is invalid with start date before today" do
    reservation.start_date = DateTime.now - 1
    expect(reservation).to be_invalid
    expect(reservation.errors[:start_date]).to include("must be today or after")
  end

  it "is invalid with end date before start date" do
    reservation.end_date = reservation.start_date - 1.days
    expect(reservation).to be_invalid
    expect(reservation.errors[:end_date]).to include("must be after start date")
  end

end