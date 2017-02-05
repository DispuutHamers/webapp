#entry point for notes
class NotesController < ApplicationController
  include ParamsHelper
  include UtilHelper
  before_action :admin_user?
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all.paginate(page: params[:page])
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    note = Note.new(note_params)
    save_object(note)
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    update_object(@note, note_params)
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    delete_object(@note)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end
end
