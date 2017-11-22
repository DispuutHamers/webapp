#entry point for nicknames resource
class NicknamesController < ApplicationController
  before_action :lid?

  def index
    @nicknames = Nickname.with_user.all
  end

  def show
    redirect_to nicknames_path
  end

  def new
    @nickname = Nickname.new
  end

  def create
    nickname = Nickname.new(nickname_params)
    save_object(nickname, type="nickname")
  end

  def edit
    @nickname = Nickname.find(params[:id])
    @userid = @nickname.user_id
  end

  def update
    nickname = Nickname.find(params[:id])
    update_object(nickname, nickname_params)
  end

  def destroy
    nickname = Nickname.find(params[:id])
    delete_object(nickname)
  end
end
