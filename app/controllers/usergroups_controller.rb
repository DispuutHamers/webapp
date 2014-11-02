class UsergroupsController < ApplicationController
before_action :admin_user?

def index
@usergroups = Usergroup.all
@group = Usergroup.new
end

def create
    @usergroup = Usergroup.new(usergroup_params)
    if @usergroup.save
      flash[:succes] = "Quote staat erop" 
      redirect_to root_url
    else
      @usergroups = Usergroup.all
      render 'groups'
    end
end

def destroy
end

private
    def usergroup_params
        params.require(:usergroup).permit(:name, :text)
    end
    
    def admin_user
      @quote = Quote.find_by_id(params[:id])
      redirect_to root_url, notice: "Niet genoeg access bitch" unless current_user.admin?
    end

end
