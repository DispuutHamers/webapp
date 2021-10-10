class BrewsController < ApplicationController
  before_action :lid?
  before_action :set_brew, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Recepten', :recipes_path

  def show
    @recipe = @brew.recipe

    breadcrumb @brew.recipe.name, recipe_path(@brew.recipe)
    breadcrumb "Uitvoeringen", recipe_path(@brew.recipe)
    breadcrumb @brew.created_at.strftime("%d-%m-%Y"), brew_path(@brew)
  end

  def new
    @recipe = Recipe.find_by_id!(params[:id])
    @brew = @recipe.brews.build(recipe_id: @recipe.id)

    breadcrumb @recipe.name, recipe_path(@recipe)
    breadcrumb 'Nieuwe uitvoering', new_brew_path(@recipe)
  end

  def create
    brew = Brew.new(brew_params)
    brew.recipe = Recipe.find_by_id!(params[:id])
    save_object(brew)
  end

  def edit
    @recipe = @brew.recipe

    breadcrumb @recipe.name, recipe_path(@recipe)
    breadcrumb "Uitvoeringen", recipe_path(@recipe)
    breadcrumb @brew.created_at.strftime("%d-%m-%Y"), brew_path(@brew)
    breadcrumb 'Wijzig', edit_brew_path(@brew)
  end

  def update
    update_object(@brew, brew_params)
  end

  def destroy
    delete_object(@brew)
  end

  private

  def set_brew
    @brew ||= Brew.find_by_id!(params[:id])
  end
end
