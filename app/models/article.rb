class Article < ActiveRecord::Base
  has_many :notes, as: :noteable
end
