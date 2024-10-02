require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "should save movie with valid attributes" do
    movie = Movie.new(name: 'Test Movie', description: 'Test Description')
    assert movie.save
  end

  test "should not save movie without a name" do
    movie = Movie.new(description: 'Test Description')
    assert_not movie.save, "Saved the movie without a name"
    assert_includes movie.errors[:name], "can't be blank"
  end

  test "should have many reviews" do
    movie = movies(:movie_one)
    assert_equal 2, movie.reviews.count
  end

  test "destroying movie should destroy associated reviews" do
    movie = movies(:movie_one)
    assert_difference('Review.count', -2) do
      movie.destroy
    end
  end
end
