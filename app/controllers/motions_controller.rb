class MotionsController < ApplicationController
  before_action :set_motion, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?

  # GET /motions
  # GET /motions.json
  def index
    @motions = Motion.all
  end

  # GET /motions/1
  # GET /motions/1.json
  def show
  end

  # GET /motions/new
  def new
    @motion = Motion.new
  end

  # GET /motions/1/edit
  def edit
  end

  # POST /motions
  # POST /motions.json
  def create
    @motion = Motion.new(motion_params)

    respond_to do |format|
      if @motion.save
        format.html { redirect_to @motion, notice: 'Motion was successfully created.' }
        format.json { render action: 'show', status: :created, location: @motion }
      else
        format.html { render action: 'new' }
        format.json { render json: @motion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /motions/1
  # PATCH/PUT /motions/1.json
  def update
    respond_to do |format|
      if @motion.update(motion_params)
        format.html { redirect_to @motion, notice: 'Motion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @motion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motions/1
  # DELETE /motions/1.json
  def destroy
    @motion.destroy
    respond_to do |format|
      format.html { redirect_to motions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motion
      @motion = Motion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def motion_params
      params.require(:motion).permit(:motion_type, :subject, :content)
    end
end
