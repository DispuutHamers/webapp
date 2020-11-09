#Entry point for the blog resource
class BlogitemsController < ApplicationController
  before_action :ilid?, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Blog', :blogitems_path

  def index
    if current_user&.active?
      @items = Blogitem.all.reverse
    else
      @items = Blogitem.where(public: true).reverse
    end
  end

  def show
    if !@item.public && !current_user&.active?
      redirect_to blogitems_path
    end
    # @user = User.find(@item.user_id)
    breadcrumb @item.title, blogitem_path(@item)
  end

  def add_photo
    photo = Blogphoto.create(photo_params)
    blog = Blogitem.unscoped.find(params[:id])
    photo.save
    redirect_to edit_blogitem_path(blog)
  end

  def destroy_photo
    photo = Blogphoto.find(params[:blogphoto])
    blog = Blogitem.unscoped.find(params[:blogitem])
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
    # TODO: validation that title exists
    item = Blogitem.new(blog_params)
    item.user_id = current_user.id
    save_object(item)
  end

  def update
    update_object(@item, blog_params)
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
