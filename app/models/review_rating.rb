class ReviewRating < ApplicationRecord
  belongs_to :review
  belongs_to :category

  validates :score, presence: true, inclusion: { in: 1..5 }
  validates :category_id, uniqueness: { scope: :review_id }
end
