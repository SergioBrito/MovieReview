require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:movie_one)
  end

  test "should get index" do
    get movies_url
    assert_response :success
    assert_select 'h1', 'Movies'
    assert_select 'div#movies' do
      assert_select 'div', minimum: 1  # Ensure at least one movie is listed
    end
  end

  test "should get new" do
    get new_movie_url
    assert_response :success
    assert_select 'h1', 'New movie'
  end

  test "should create movie" do
    assert_difference("Movie.count") do
      post movies_url, params: { movie: { name: 'New Movie', description: 'A new test movie.' } }
    end

    assert_redirected_to movie_url(Movie.last)
    follow_redirect!
    assert_select 'h1', 'New Movie'
    assert_select 'p', text: /Description:\s*A new test movie./
  end

  test "should show movie" do
    get movie_url(@movie)
    assert_response :success
    assert_select 'h1', @movie.name
    assert_select 'p', text: /Description:\s*#{@movie.description}/
  end

  test "should get edit" do
    get edit_movie_url(@movie)
    assert_response :success
    assert_select 'h1', 'Editing movie'
  end

  test "should update movie" do
    patch movie_url(@movie), params: { movie: { name: 'Updated Name', description: 'Updated description.' } }
    assert_redirected_to movie_url(@movie)
    @movie.reload
    assert_equal 'Updated Name', @movie.name
    assert_equal 'Updated description.', @movie.description
  end

  test "should not create movie with invalid params" do
    assert_no_difference('Movie.count') do
      post movies_url, params: { movie: { name: '', description: '' } }
    end
    assert_response :unprocessable_entity
    assert_select 'div', text: /error(s)? prohibited this movie from being saved/
  end

  test "should not update movie with invalid params" do
    patch movie_url(@movie), params: { movie: { name: '', description: '' } }
    assert_response :unprocessable_entity
    @movie.reload
    assert_not_equal '', @movie.name
  end

  test "should destroy movie" do
    assert_difference("Movie.count", -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
