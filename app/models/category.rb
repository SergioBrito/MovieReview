class Category < ApplicationRecord
  has_many :review_ratings

  validates :name, presence: true
end
