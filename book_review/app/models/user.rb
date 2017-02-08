class User < ApplicationRecord
  has_many :requests
  has_many :activities
  has_many :likes
  has_many :statuses
  has_many :comments
  has_many :reviews
  has_many :relationships

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
    
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
