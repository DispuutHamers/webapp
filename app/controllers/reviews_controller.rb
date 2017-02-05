#entry point for review resource
class ReviewsController < ApplicationController
  before_action :logged_in?, only: [:index, :edit, :update, :destroy]
  before_action :admin_user?, only: [:destroy]
  before_action :correct_user, only: [:edit, :update]

  def create
    review = Review.new(review_params)
    beer = Beer.find(params[:review][:beer_id]) # Nog nakijken voor injection
    reviews = User.find(params[:review][:user_id]).reviews.where(beer_id: @beer.id)
    redirect_to beer, notice: 'Doe es niet valsspelen' and return if reviews.any?
    save_object(review, type="review", push=true) 
  end

  def edit
    @review = Review.find(params[:id])
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
    redirect_to root_url, notice: 'Niet genoeg access' unless current_user?(@user) or current_user.admin? or current_user.schrijf_feut?
  end
end
