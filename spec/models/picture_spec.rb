require 'rails_helper'

describe Picture, type: :model do

  let(:picture) { FactoryGirl.build(:picture) }

  it "has a valid factory" do
    expect(picture).to be_valid
  end
    
end