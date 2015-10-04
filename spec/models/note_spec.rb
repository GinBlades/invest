require "rails_helper"

RSpec.describe Note, type: :model do
  it "has a valid factory" do
    expect(build(:note)).to be_valid
  end
end
