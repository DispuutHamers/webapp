class ReviewsController < ApplicationController
  include SessionsHelper
 
  def create
    @user = User.find(params[:review][:user_id])
    @beer = Beer.find(params[:review][:beer_id])
    @rating = params[:review][:rating]
    @beer.add_review!(@user, @rating, params[:review][:description])  
    redirect_to @beer
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
    def review_params
      params.require(:review).permit(:user_id, :beer_id, :description, :rating)
    end
  
end
