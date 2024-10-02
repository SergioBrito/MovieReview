require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:movie_one)
    @review = reviews(:review_one)
  end

  test "should get index" do
    get movie_reviews_url(@movie)
    assert_response :success
    assert_select 'h1', "Reviews for #{@movie.name}"
    assert_select 'div' do
      assert_select 'p strong', text: 'Reviewer:'
      assert_select 'p', text: /Alice|Anonymous/
    end
  end

  test "should show review" do
    get movie_review_url(@movie, @review)
    assert_response :success
    assert_select 'h1', "Review for #{@movie.name}"
    assert_select 'p strong', text: 'Reviewer:'
    assert_select 'p', text: /Alice|Anonymous/
    assert_select 'h3', 'Ratings:'
    assert_select 'ul' do
      @review.review_ratings.each do |rating|
        assert_select 'li', text: /#{rating.category.name}:\s*#{rating.score}/
      end
    end
    assert_select 'p strong', text: 'Total Score:'
    assert_select 'p', text: /#{@review.total_score}/
  end

  test "should get new" do
    get new_movie_review_url(@movie)
    assert_response :success
    assert_select 'h1', "New Review for #{@movie.name}"
    assert_select 'form' do
      assert_select 'input[name="review[reviewer_name]"]', 1
      assert_select 'input[type="hidden"][name*="[category_id]"]', Category.count
      assert_select 'select[name*="[score]"]', Category.count
      assert_select 'input[type="submit"]', 1
    end
  end

  test "should create review with valid data" do
    assert_difference('Review.count', 1) do
      assert_difference('ReviewRating.count', Category.count) do
        post movie_reviews_url(@movie), params: {
          review: {
            reviewer_name: 'Test Reviewer',
            review_ratings_attributes: Category.all.map { |category|
              { category_id: category.id, score: 4 }
            }
          }
        }
      end
    end
    assert_redirected_to movie_review_url(@movie, Review.last)
    follow_redirect!
    assert_select 'p', text: /Reviewer:\s*Test Reviewer/
    assert_select 'p', text: /Total Score:\s*4.0/
  end

  test "should not create review with invalid data" do
    assert_no_difference('Review.count') do
      post movie_reviews_url(@movie), params: {
        review: {
          reviewer_name: '',
          review_ratings_attributes: []
        }
      }
    end
    assert_response :success
    assert_select 'div', text: /error(s)? prohibited this review from being saved/
  end

  test "should not create review without required category ratings" do
    assert_no_difference('Review.count') do
      post movie_reviews_url(@movie), params: {
        review: {
          reviewer_name: 'Test Reviewer',
          review_ratings_attributes: [
            { category_id: categories(:optional_category).id, score: 3 }
          ]
        }
      }
    end
    assert_response :success
    assert_select 'div', text: /Missing ratings for required categories/
  end

  test "should get index with no reviews" do
    @movie.reviews.destroy_all
    get movie_reviews_url(@movie)
    assert_response :success
    assert_select 'h1', "Reviews for #{@movie.name}"
    assert_select 'div', { count: 0, text: /Reviewer:/ }
  end

  test "should create anonymous review" do
    assert_difference('Review.count', 1) do
      post movie_reviews_url(@movie), params: {
        review: {
          reviewer_name: '',
          review_ratings_attributes: Category.all.map { |category|
            { category_id: category.id, score: 5 }
          }
        }
      }
    end
    assert_redirected_to movie_review_url(@movie, Review.last)
    follow_redirect!
    assert_select 'p', text: /Reviewer:\s*Anonymous/
  end
end
