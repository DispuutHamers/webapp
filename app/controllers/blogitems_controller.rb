#Entry point for the blog resource
class BlogitemsController < ApplicationController
  before_action :logged_in?, only: [:edit, :update, :destroy, :create, :new]
  before_action :admin_user?, only: [:destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if current_user&.lid? 
      @items = Blogitem.all
    else
      @items = Blogitem.where(public: true)
    end
  end

  def show
    if !@item.public && !current_user&.lid?
      redirect_to blogitems_path 
    end
  end

  def new
    @item = Blogitem.new
  end

  def edit
  end

  def create
    item = Blogitem.new(blog_params)
    item.user_id = current_user.id
    save_object(item, push=true)
  end

  def update
    update_by_owner_or_admin(@item, blog_params)
  end

  def destroy
    delete_object(@item)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Blogitem.find(params[:id])
  end
end
