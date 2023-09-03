class BeersController < ApplicationController
  before_action :set_beer, only: [:reviews, :show, :edit, :update, :destroy]
  before_action :ilid?, except: [:index, :show, :search, :table]
  layout :set_template, only: [:index, :show, :table]
  breadcrumb 'Bieren', :beers_path
  ALLOWED_SORTING_FIELDS = %w[name kind grade brewer country review_count]

  # GET /beers
  # GET /beers.json
  def index
    @search = Beer.ransack(params[:search])
  end

  def table
    @search = Beer.ransack(params[:search])
    @pagy, @beers = pagy(@search.result, items: 16, page: params[:page])
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    breadcrumb @beer.name, beer_path(@beer)

    @reviews = @beer.reviews.with_user
  end

  def reviews
    breadcrumb @beer.name, beer_path(@beer)
    breadcrumb 'Review', reviews_beer_path(@beer)
  end

  # GET /beers/new
  def new
    @beer = Beer.new
    breadcrumb "Bier toevoegen", new_beer_path
  end

  # GET /beers/1/edit
  def edit
    breadcrumb @beer.name, beer_path(@beer)
    breadcrumb "Aanpassen", edit_beer_path(@beer)
  end

  # POST /beers
  # POST /beers.json
  def create
    beer = Beer.new(beer_params)
    save_object(beer)
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
    @beer = Beer.find_by_id!(params[:id])
  end

  def set_template
    'application_public' unless current_user&.active?
  end

  def ilid_and_otp_required?
    current_user&.active? && !otp_required?
  end
end
