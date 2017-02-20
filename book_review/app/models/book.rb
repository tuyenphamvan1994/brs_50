class Book < ApplicationRecord
  belongs_to :category
  
  has_many :reviews
  has_many :statuses

  has_many :favorite_books, dependent: :destroy

  mount_uploader :image, ImageUploader
  
  validates :image, presence: true
  validates :title, presence: true
  validates :author, presence: true
  validates :number_page, presence: true, numericality: true
  validates :publish_date, presence: true
  validates :category, presence: true
end
