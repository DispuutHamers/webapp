class VotesController < ApplicationController
  before_action :admin_user?, only: [:destroy]
  before_action :set_vote, only: [:destroy]
  before_action :logged_in?

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @poll = Poll.find(params[:vote][:poll_id])
    current_user.vote!(@poll, params[:vote][:result])
    redirect_to polls_path
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:user_id, :result, :poll_id)
  end
end
