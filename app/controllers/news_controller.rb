#Entry point for the news resource
class NewsController < ApplicationController
  before_action :ilid?
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Nieuws', :news_index_path

  # GET /news
  # GET /news.json
  def index
    @news = News.all.order(created_at: :desc).limit(10)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    redirect_to news_index_path
  end

  # GET /news/new
  def new
    @news = News.new
    breadcrumb 'Nieuw Nieuws', :new_news_path
  end

  # GET /news/1/edit
  def edit
    breadcrumb @news.title, edit_news_path(@news)
  end

  # POST /news
  # POST /news.json
  def create
    news = News.new(news_params)
    news.user_id = current_user.id
    news.date = Time.now
    save_object(news)
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    update_by_owner_or_admin(@news, news_params)
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    delete_object(@news)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_news
    @news = News.find(params[:id])
  end
end
