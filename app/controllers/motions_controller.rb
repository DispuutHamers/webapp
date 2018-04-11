#entry point for motions resource
class MotionsController < ApplicationController
  before_action :set_motion, only: [:show, :edit, :update, :destroy]
  before_action :lid?
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
    motion = Motion.new(motion_params)
    motion.user_id = current_user.id
    save_object(motion)
  end

  # PATCH/PUT /motions/1
  # PATCH/PUT /motions/1.json
  def update
    update_by_owner_or_admin(@motion, motion_params)
  end

  # DELETE /motions/1
  # DELETE /motions/1.json
  def destroy
    delete_object(@motion)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_motion
    @motion = Motion.find(params[:id])
  end
end
