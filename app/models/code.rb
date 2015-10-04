class Code < ActiveRecord::Base
  belongs_to :company
  has_many :notes, as: :noteable
  has_many :quotes, dependent: :destroy

  def to_s
    symbol
  end
end
