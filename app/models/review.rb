class Review < ApplicationRecord
  belongs_to :movie
  has_many :review_ratings, dependent: :destroy
  accepts_nested_attributes_for :review_ratings

  validate :required_categories_present

  def required_categories_present
    required_category_ids = Category.where(required: true).pluck(:id)
    provided_category_ids = review_ratings.map(&:category_id)
    missing_categories = required_category_ids - provided_category_ids
    if missing_categories.any?
      errors.add(:base, 'Missing ratings for required categories.')
    end
  end

  def total_score
    scores = review_ratings.map(&:score)
    (scores.sum.to_f / scores.size).round(2)
  end
end
