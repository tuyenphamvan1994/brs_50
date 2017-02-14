class Book < ApplicationRecord
  belongs_to :category
  
  has_many :reviews
  has_many :statuses
  scope :load_book_from_category_id, -> category_id {where category_id: category_id}
end
