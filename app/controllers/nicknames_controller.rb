#entry point for nicknames resource
class NicknamesController < ApplicationController
  before_action :logged_in?, only: [:index, :new, :create, :update, :destroy, :edit]
  before_action :admin_user?, only: [:update, :destroy, :edit]


  def index
    @nicknames = Nickname.all
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
