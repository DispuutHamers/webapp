#Handles calls to '/news'
class Api2::NewsController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/news', "Show news index"
  def index
    render json: News.all
  end

  api :GET, '/news/:id', "Show news"
  def show
    render json: News.find(params[:id])
  end

  api :UPDATE, '/news/:id', 'Update news'
  param :cat, ['e', 'd', 'l']
  param :body, String
  param :title, String
  param :image, String
  def update
    news = News.find(params[:id])
    update_by_owner_or_admin(news, news_params)
  end

  api :POST, '/news', 'Create news'
  param :cat, ['e', 'd', 'l'], :required => true
  param :body, String, :required => true
  param :title, String, :required => true
  param :image, String
  def create
    news = News.new(news_params)
    news.user_id = key.user.id
    news.date = Time.now
    save_object(news, type="news", push = true)
  end
end
