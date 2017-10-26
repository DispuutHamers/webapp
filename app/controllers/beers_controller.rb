#entry point for beer resource
class BeersController < ApplicationController
  before_action :set_beer, only: [:reviews, :show, :edit, :update, :destroy]
  before_action :ilid?

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.all
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
  end

  def reviews
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
