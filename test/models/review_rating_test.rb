require "test_helper"

class ReviewRatingTest < ActiveSupport::TestCase
  test "should save review_rating with valid attributes" do
    review_rating = ReviewRating.new(
      review: reviews(:review_one),
      category: categories(:optional_category),
      score: 3
    )
    assert review_rating.save
  end

  test "should not save review_rating with invalid score" do
    review_rating = ReviewRating.new(
      review: reviews(:review_one),
      category: categories(:optional_category),
      score: 6
    )
    assert_not review_rating.save, "Saved review_rating with score greater than 5"
    assert_includes review_rating.errors[:score], "is not included in the list"

    review_rating.score = 0
    assert_not review_rating.valid?, "ReviewRating is valid with score less than 1"
    assert_includes review_rating.errors[:score], "is not included in the list"
  end

  test "should not allow duplicate category ratings per review" do
    review_rating = ReviewRating.new(
      review: reviews(:review_one),
      category: categories(:performance),
      score: 4
    )
    assert_not review_rating.save, "Saved duplicate review_rating for the same category and review"
    assert_includes review_rating.errors[:category_id], "has already been taken"
  end

  test "should require a score" do
    review_rating = ReviewRating.new(
      review: reviews(:review_one),
      category: categories(:optional_category)
      # score is missing
    )
    assert_not review_rating.save, "Saved review_rating without a score"
    assert_includes review_rating.errors[:score], "can't be blank"
  end
end
