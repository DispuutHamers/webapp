class MissionController < ApplicationController
  before_action :lid?
  before_action -> { redirect_to root_path unless current_user.dev? }
end
