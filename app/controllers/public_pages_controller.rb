# Hosts our public pages
class PublicPagesController < ApplicationController
  before_action :lid?, except: [:show]
  before_action :set_public_page, only: [:edit, :update, :destroy]

  # GET /public_pages
  # GET /public_pages.json
  def index
    @public_pages = PublicPage.all.paginate(page: params[:page])
  end

  # GET /public_pages/1
  # GET /public_pages/1.json
  def show
    @public_page = PublicPage.where(title: params[:id]).first
    redirect_to root_path if !@public_page
    redirect_to root_path if !@public_page.public && !current_user&.active?
  end

  def find_id 
    title = PublicPage.where(id: params[:id]).first.title
    redirect_to "/#{title}"
  end

  # GET /public_pages/new
  def new
    @public_page = PublicPage.new
  end

  # GET /public_pages/1/edit
  def edit
  end

  # POST /public_pages
  # POST /public_pages.json
  def create
    public_page = PublicPage.new(public_page_params)
    save_object(public_page, type="public page")
  end

  # PATCH/PUT /public_pages/1
  # PATCH/PUT /public_pages/1.json
  def update
    update_object(@public_page, public_page_params)
  end

  # DELETE /public_pages/1
  # DELETE /public_pages/1.json
  def destroy
    @public_page.destroy
    respond_to do |format|
      format.html { redirect_to public_pages_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_public_page
    @public_page = PublicPage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def public_page_params
    params.require(:public_page).permit(:content, :title, :public)
  end
end
