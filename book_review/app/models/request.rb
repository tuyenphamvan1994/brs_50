class Request < ApplicationRecord
  belongs_to :user
  
  enum status: {pending: 0, accept: 1, refuse: 2}
  scope :sort_by_created_at, ->{order created_at: :desc}
end
