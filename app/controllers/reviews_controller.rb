class ReviewsController < ApplicationController
  before_action :logged_in?, only: [:index, :edit, :update, :destroy]
  before_action :admin_user?, only: [:destroy]
  before_action :correct_user, only: [:edit, :update]
 
  def create
    @review = Review.new(review_params)
    @beer = Beer.find(params[:review][:beer_id]) # Nog nakijken voor injection
    reviews = User.find(params[:review][:user_id]).reviews.where(beer_id: @beer.id)
    redirect_to @beer, notice: 'Doe es niet valsspelen' and return if reviews.any?
    respond_to do |format|
      if @review.save
        format.html { redirect_to @beer, notice: 'Review was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review.beer, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @beer = @review.beer
    @review.destroy
    flash[:success] = "Review destroyed"
    redirect_to @beer
  end
  
  private 
    def correct_user
      @user = Review.find(params[:id]).user
      redirect_to root_url, notice: "Niet genoeg access" unless current_user?(@user) or current_user.admin? or current_user.schrijf_feut?
    end
end
