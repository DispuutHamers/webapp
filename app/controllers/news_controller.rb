#Entry point for the news resource
class NewsController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:edit, :update, :destroy,]
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    @news = News.all.order(created_at: :desc).limit(10)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    redirect_to root_path
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    news = News.new(news_params)
    news.user_id = current_user.id
    news.date = Time.now
    save_object(news, type = "news") #rare bug die alles stuk maakt bij aanmaken push
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
