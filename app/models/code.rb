class Code < ActiveRecord::Base
  belongs_to :company
  has_many :notes, as: :noteable
  has_many :quotes, dependent: :destroy

  before_save :format_symbol

  validates :symbol, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    symbol
  end

  def format_symbol
    self.symbol = symbol.upcase
  end
end
