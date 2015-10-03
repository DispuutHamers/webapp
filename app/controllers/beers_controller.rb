class BeersController < ApplicationController
  include SessionsHelper
  before_action :set_beer, only: [:reviews, :show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:index, :edit, :update, :show]
  before_action :admin_user?, only: [:destroy, :update, :edit]

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
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
	update_app("{ data: { beer: { id: \"#{@beer.id}\", name: \"#{@beer.name}\", soort: \"#{@beer.soort}\", picture: \"#{@beer.picture}\", percentage: \"#{@beer.percentage}\", brewer: \"#{@beer.brewer}\", country: \"#{@beer.country}\", URL: \"#{@beer.URL}\", cijfer: \"null\", created_at: #{@beer.created_at.to_json}  } } }")
        format.html { redirect_to @beer, notice: 'Beer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @beer }
      else
        format.html { render action: 'new' }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end
end
