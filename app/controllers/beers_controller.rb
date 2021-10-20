#entry point for beer resource
class BeersController < ApplicationController
  before_action :set_beer, only: [:reviews, :show, :edit, :update, :destroy]
  before_action :ilid?, except: [:index, :show, :search]
  layout :set_template, only: [:index, :show]
  breadcrumb 'Bieren', :beers_path
  ALLOWED_SORTING_FIELDS = %w[name kind grade brewer country review_count]

  # GET /beers
  # GET /beers.json
  def index
    sorting = params[:sort] if ALLOWED_SORTING_FIELDS.include?(params[:sort])
    ordering = params[:order] if %w[asc desc].include?(params[:order])
    @sp = params[:search] || ""
    if sorting == "review_count"
      @pagy, @beers = pagy(BeerFilter.new.filter(Beer.all, @sp)
                                     .left_joins(:reviews)
                                     .group(:beer_id)
                                     .order("count(reviews.id) #{ordering}"),
                           items: 16,
                           page: params[:page])
    else
      sorting = "name" unless sorting
      ordering = "ASC" unless ordering
      @pagy, @beers = pagy(BeerFilter.new.filter(Beer.all, @sp).reorder("#{sorting} #{ordering}"),
                           items: 16,
                           page: params[:page])
    end
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
end
