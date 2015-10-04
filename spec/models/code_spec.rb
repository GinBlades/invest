require "rails_helper"

RSpec.describe Code, type: :model do
  it "has a valid factory" do
    expect(build(:code)).to be_valid
  end
end
