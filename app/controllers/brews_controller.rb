class BrewsController < ApplicationController
  before_action :brewer?
  before_action :set_brew, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Brouwsels', :brews_path


  def show
    @recipe = @brew.recipe
    breadcrumb @brew.name, brew_path(@brew)
  end

  def new
    @recipe = Recipe.find(params[:id])
    @brew = @recipe.brews.build(recipe_id: @recipe.id)
  end

  def create
    brew = Brew.new(brew_params)
    brew.recipe = Recipe.find(params[:id])
    save_object(brew)
  end

  def edit
    @recipe = @brew.recipe
  end

  def update
    update_object(@brew, brew_params)
  end

  def destroy
    delete_object(@brew)
  end

  private
  def set_brew
    @brew = Brew.find(params[:id])
  end
end
