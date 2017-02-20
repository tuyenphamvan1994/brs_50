class Book < ApplicationRecord
  belongs_to :category
  
  has_many :reviews, dependent: :destroy
  has_many :statuses, dependent: :destroy

  has_many :favorite_books, dependent: :destroy

  mount_uploader :image, ImageUploader

  scope :search_by, ->search {where "title LIKE ? OR author LIKE ?",
    "%#{search}%", "%#{search}%"}
  scope :search_by_title, ->search_title {where "title LIKE ?",
    "%#{search_title}%"}
  
  validates :image, presence: true
  validates :title, presence: true
  validates :author, presence: true
  validates :number_page, presence: true, numericality: true
  validates :publish_date, presence: true
  validates :category, presence: true
end
