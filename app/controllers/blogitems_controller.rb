#Entry point for the blog resource
class BlogitemsController < ApplicationController
  before_action :ilid?, except: %i[index show]
  before_action :set_item, only: %i[show edit update destroy]
  breadcrumb 'Blog', :blogitems_path
  layout :set_template, only: %i[index show]

  def index
    @items = if current_user&.active?
               Blogitem.all.reverse
             else
               @items = Blogitem.public_blogs.reverse
             end
  end

  def show
    return redirect_to blogitems_path unless @item.public || current_user&.active?

    @user = User.find_by(id: @item&.user_id)
    breadcrumb @item.title, blogitem_path(@item)
  end

  def new
    @item = Blogitem.new
  end

  def edit
    breadcrumb @item.title, blogitem_path(@item)
    breadcrumb "Aanpassen", edit_blogitem_path(@item)
  end

  def update
    @item.user ||= current_user
    update_object(@item, blog_params)
  end

  def destroy
    delete_object(@item)
  end

  private

  def set_item
    @item = Blogitem.unscoped.find_by_id!(params[:id])
  end

  def set_template
    'application_public' unless current_user&.active?
  end
end
