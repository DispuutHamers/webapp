class MotionsController < ApplicationController
  before_action :set_motion, only: [:show, :edit, :update, :destroy]
	before_action :logged_in?
	before_action :admin_user?, except: [:new, :create]

  # GET /motions
  # GET /motions.json
  def index
    @motions = Motion.all.paginate(page: params[:page])
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
		@motion.user_id = current_user.id
    respond_to do |format|
      if @motion.save
        format.html { redirect_to root_path, notice: 'Je motie wordt behandeld.' }
      else
        format.html { render action: 'new' }
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
end
