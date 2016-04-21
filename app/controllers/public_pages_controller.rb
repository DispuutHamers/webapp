class PublicPagesController < ApplicationController
  before_action :set_public_page, only: [:edit, :update, :destroy]
  before_action :admin_user?, except: [:show]

  # GET /public_pages
  # GET /public_pages.json
  def index
    @public_pages = PublicPage.all.paginate(page: params[:page])
  end

  # GET /public_pages/1
  # GET /public_pages/1.json
  def show
    @public_page = PublicPage.where(title: params[:id]).first
    redirect_to root_path unless @public_page != nil
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
    @public_page = PublicPage.new(public_page_params)

    respond_to do |format|
      if @public_page.save
        flash[:success] = 'Publieke pagina succesvol aangemaakt.'
        format.html { redirect_to @public_page }
        format.json { render action: 'show', status: :created, location: @public_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @public_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_pages/1
  # PATCH/PUT /public_pages/1.json
  def update
    respond_to do |format|
      if @public_page.update(public_page_params)
        flash[:success] = 'Publieke pagina succesvol bijgewerkt.'
        format.html { redirect_to @public_page }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @public_page.errors, status: :unprocessable_entity }
      end
    end
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
