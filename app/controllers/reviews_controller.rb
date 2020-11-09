# entry point for review resource
class ReviewsController < ApplicationController
  before_action :ilid?
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    review = current_user.reviews.new(review_params)
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
