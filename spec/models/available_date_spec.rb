require 'rails_helper'

describe AvailableDate, type: :model do

  let(:available) { FactoryGirl.build(:available_date) }
  let(:member) { FactoryGirl.create(:member) }

  it "has a valid factory" do
    expect(available).to be_valid
  end

  it "is invalid without a location id" do
    available.location_id = nil
    expect(available).to be_invalid
    expect(available.errors[:location_id]).to include("can't be blank")
  end

  it "is invalid without a status" do
    available.status = nil
    expect(available).to be_invalid
    expect(available.errors[:status]).to include("can't be blank")
  end

  it "is invalid without an available_date" do
    available.available_date = nil
    expect(available).to be_invalid
    expect(available.errors[:available_date]).to include("can't be blank")
  end

  it "is invalid without a numerical price" do
    available.price_cents = nil
    expect(available).to be_invalid
    expect(available.errors[:price]).to include("is not a number")
  end

  it "is properly updated when held for a member" do
    available.hold_for_member(member)
    expect(available).to be_valid
    expect(available.member_id).to eq member.id
    expect(available.held?).to be_truthy
  end

  it "is properly updated when reserved for a member" do
    available.reserve_for_member(member)
    expect(available).to be_valid
    expect(available.member_id).to eq member.id
    expect(available.reserved?).to be_truthy
  end

  it "is properly released" do
    available.reserve_for_member(member)
    expect(available).to be_valid
    expect(available.member_id).to eq member.id
    expect(available.reserved?).to be_truthy
    available.release
    expect(available.member_id).to be_nil
    expect(available.available?).to be_truthy
  end
end
