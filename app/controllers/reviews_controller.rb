class ReviewsController < ApplicationController
  before_action :set_movie

  def index
    @reviews = @movie.reviews.includes(review_ratings: :category)
  end

  def show
    @review = @movie.reviews.find(params[:id])
  end

  def new
    @review = @movie.reviews.build
    build_review_ratings
  end

  def create
    @review = @movie.reviews.build(review_params)
    if @review.save
      redirect_to movie_review_path(@movie, @review), notice: 'Review was successfully created.'
    else
      build_review_ratings
      render :new
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:reviewer_name, review_ratings_attributes: [:category_id, :score])
  end

  def build_review_ratings
    @categories = Category.all
    @categories.each do |category|
      @review.review_ratings.build(category: category) unless @review.review_ratings.map(&:category_id).include?(category.id)
    end
  end
end
