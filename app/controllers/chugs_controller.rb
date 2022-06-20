
# Entry point for the chug resource
class ChugsController < ApplicationController
  before_action :ilid?
  breadcrumb 'Adtjes', :chugs_path

  def index
    @items = if current_user&.active?
               Chug.all.reverse
             else
               Chug.public_blogs.reverse
             end
  end

  def show
    redirect_to root_path
  end

  def create
    chug = User.find(micropost_params[:user_id]).chugs.build(micropost_params)
    chug.reporter_id = current_user.id
    save_object(chug)
  end

  def edit
    @chug = Chug.find_by_id!(params[:id])
    @userid = @chug.user_id
    breadcrumb 'Wijzig Adt', edit_chug_path(@chug)
  end

  def update
    chug = Chug.find_by_id!(params[:id])
    update_object(chug, chug_params)
  end

  def destroy
    chug = Chug.find_by_id!(params[:id])
    delete_object(chug)
  end
end
