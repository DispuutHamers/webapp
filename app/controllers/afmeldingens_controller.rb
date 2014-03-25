class AfmeldingensController < ApplicationController
  before_action :set_afmeldingen, only: [:show, :edit, :update, :destroy]

  # GET /afmeldingens
  # GET /afmeldingens.json
  def index
    @afmeldingens = Afmeldingen.all
  end

  # GET /afmeldingens/1
  # GET /afmeldingens/1.json
  def show
  end

  # GET /afmeldingens/new
  def new
    @afmeldingen = Afmeldingen.new
  end

  # GET /afmeldingens/1/edit
  def edit
  end

  # POST /afmeldingens
  # POST /afmeldingens.json
  def create
    @afmeldingen = Afmeldingen.new(afmeldingen_params)

    respond_to do |format|
      if @afmeldingen.save
        format.html { redirect_to @afmeldingen, notice: 'Afmeldingen was successfully created.' }
        format.json { render action: 'show', status: :created, location: @afmeldingen }
      else
        format.html { render action: 'new' }
        format.json { render json: @afmeldingen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /afmeldingens/1
  # PATCH/PUT /afmeldingens/1.json
  def update
    respond_to do |format|
      if @afmeldingen.update(afmeldingen_params)
        format.html { redirect_to @afmeldingen, notice: 'Afmeldingen was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @afmeldingen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /afmeldingens/1
  # DELETE /afmeldingens/1.json
  def destroy
    @afmeldingen.destroy
    respond_to do |format|
      format.html { redirect_to afmeldingens_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_afmeldingen
      @afmeldingen = Afmeldingen.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def afmeldingen_params
      params.require(:afmeldingen).permit(:reden, :user_id)
    end
end
