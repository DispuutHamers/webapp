# entry point for review resource
class ReviewsController < ApplicationController
  before_action :ilid?
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    review = Review.new(review_params)
    beer = Beer.find(params[:review][:beer_id]) # Nog nakijken voor injection
    reviews = User.find(params[:review][:user_id]).reviews.where(beer_id: beer.id)
    redirect_to beer, notice: 'Doe es niet valsspelen' and return if reviews.any?
    save_object(review)
  end

  def show
    redirect_to Review.find(params[:id]).beer
  end

  def edit
    @review = Review.find(params[:id])
    breadcrumb 'Bier', :beers_path
    breadcrumb @review.beer.name, beer_path(@review.beer)
    breadcrumb 'Review', edit_review_path(@review)
  end

  def update
    review = Review.find(params[:id])
    update_by_owner_or_admin(review, review_params)
  end

  def destroy
    review = Review.find(params[:id])
    delete_object(review)
  end

  private
  def correct_user
    @user = Review.find(params[:id]).user
    redirect_to root_url, notice: 'Niet genoeg access' unless current_user?(@user) || current_user.admin?
  end
end
