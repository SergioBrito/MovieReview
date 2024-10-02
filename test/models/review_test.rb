require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  test "should save review with required categories rated" do
    review = Review.new(movie: movies(:movie_one), reviewer_name: 'Test Reviewer')
    Category.where(required: true).each do |category|
      review.review_ratings.build(category: category, score: 4)
    end
    assert review.save
  end

  test "should not save review without required categories rated" do
    review = Review.new(movie: movies(:movie_one), reviewer_name: 'Test Reviewer')
    # Only rate optional categories
    review.review_ratings.build(category: categories(:optional_category), score: 3)
    assert_not review.save, "Saved the review without required category ratings"
    assert_includes review.errors[:base], 'Missing ratings for required categories.'
  end

  test "should calculate total_score correctly including optional categories" do
    review = reviews(:review_three)
    expected_score = ((5 + 5 + 5 + 4) / 4.0).round(2)
    assert_equal expected_score, review.total_score
  end

  test "should calculate total_score correctly with only required categories" do
    review = reviews(:review_one)
    expected_score = ((4 + 5 + 4) / 3.0).round(2)
    assert_equal expected_score, review.total_score
  end

  test "should accept anonymous reviewer" do
    review = Review.new(movie: movies(:movie_one))
    Category.where(required: true).each do |category|
      review.review_ratings.build(category: category, score: 4)
    end
    assert review.save
    assert_nil review.reviewer_name
  end

  test "should belong to a movie" do
    review = Review.new(reviewer_name: 'Tester')
    Category.where(required: true).each do |category|
      review.review_ratings.build(category: category, score: 4)
    end
    assert_not review.save, "Saved the review without a movie"
    assert_includes review.errors[:movie], "must exist"
  end
end
