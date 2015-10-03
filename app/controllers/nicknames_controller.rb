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
    @nickname = Nickname.new(nickname_params)
    if @nickname.save
      redirect_to nicknames_path
    end
  
  end

  def edit
    @nickname = Nickname.find(params[:id])
    @userid = @nickname.user_id
  end

  def update
    @nickname = Nickname.find(params[:id])
    if @nickname.update(nickname_params)
      flash[:success] = "Nickname aangepast"
      redirect_to nicknames_path      
    end
  end


  def destroy
    Nickname.find(params[:id]).destroy
    flash[:success] = "Bijnaam is weg"
    redirect_to nicknames_path
  end 

end
