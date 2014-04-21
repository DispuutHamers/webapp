class ReviewsController < ApplicationController
  include SessionsHelper
 
  def create
    @user = User.find(params[:review][:user_id])
    @beer = Beer.find(params[:review][:beer_id])
    @rating = params[:review][:rating]
    @beer.add_review!(@user, @rating, params[:review][:description])  
    redirect_to @beer
  end

  def destroy
    @user = User.find(params[:group][:user_id])
    @group = Usergroup.find(params[:group][:group_id])
    @user.remove_group!(@group)
    redirect_to usergroups_user_path(@user)
  end
  
end
