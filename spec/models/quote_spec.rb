require "rails_helper"

RSpec.describe Quote, type: :model do
  it "has a valid factory" do
    expect(build(:quote)).to be_valid
  end
end
