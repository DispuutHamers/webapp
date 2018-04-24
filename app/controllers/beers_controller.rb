#entry point for beer resource
class BeersController < ApplicationController
  before_action :set_beer, only: [:reviews, :show, :edit, :update, :destroy]
  before_action :ilid?, except: [:index, :show, :search]
  breadcrumb 'Bier', :beers_path

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.all.paginate(page: params[:page])
  end

  def search
    if params["search"]
      @sp = params[:search][:terms]
      @beers = BeerFilter.new.filter(Beer.all, @sp).paginate(page: params[:page], per_page: 500)
    else
      @beers = Beer.all.paginate(page: params[:page])
    end

    breadcrumb "Zoeken", :beers_path
    render 'beers/index'
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    breadcrumb @beer.name, beer_path(@beer)
  end

  def reviews
    breadcrumb @beer.name, beer_path(@beer)
    breadcrumb 'Review', reviews_beer_path(@beer)
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers
  # POST /beers.json
  def create
    beer = Beer.new(beer_params)
    save_object(beer, push=true)
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    update_object(@beer, beer_params)
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    delete_object(@beer)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_beer
    @beer = Beer.find(params[:id])
  end
end
