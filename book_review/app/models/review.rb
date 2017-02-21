class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_many :comments, dependent: :destroy

  validates :review, presence: true
  
  validates :rate, presence: true, numericality: true
end
