class Book < ApplicationRecord
  belongs_to :category
  
  has_many :reviews
  has_many :statuses
end
