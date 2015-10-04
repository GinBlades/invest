class Company < ActiveRecord::Base
  has_many :codes, dependent: :destroy
  has_many :notes, as: :noteable
  accepts_nested_attributes_for :codes, reject_if: :all_blank, allow_destroy: true

  def to_s
    name
  end
end
