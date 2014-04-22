class ReviewsController < ApplicationController
  include SessionsHelper
 
  def create
    @review = Review.new(review_params)
    @beer = Beer.find(params[:review][:beer_id])
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
    def review_params
      params.require(:review).permit(:user_id, :beer_id, :description, :rating, :proefdatum)
    end
  
end
