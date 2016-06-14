require 'rails_helper'

RSpec.describe Member, type: :model do

  it "has a valid factory" do
    expect(build(:member)).to be_valid
  end

  it "is invalid without a first_name" do
    expect(build(:member, email: nil)).to be_invalid
  end
    
  it "is invalid without a last_name" do
    expect(build(:member, password: nil)).to be_invalid
  end
  
end
