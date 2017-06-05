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

  def add_photo
    photo = Blogphoto.create(photo_params)
    photo.save
    redirect_to edit_blogitem_path(photo.blogitem)
  end

  def destroy_photo
    photo = Blogphoto.find(params[:blogphoto])
    blog = Blogitem.find(params[:blogitem])
    photo.destroy
    redirect_to edit_blogitem_path(blog)
  end

  def new
    @item = Blogitem.new
    @item.save
    @photo = Blogphoto.new
  end

  def edit
    @photo = Blogphoto.new
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
    @item = Blogitem.unscoped.find(params[:id])
  end
end
