class RecipeController < ApplicationController
  before_action :lid?
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Recepten', :recipe_index_path

  def index
    @recipes = Recipe.all.paginate(page: params[:page])
  end

  def show
    @brews = @recipe.brews

    breadcrumb @recipe.name, recipe_path(@recipe)
  end

  def edit
    breadcrumb @recipe.name, recipe_path(@recipe)
    breadcrumb 'Wijzig', edit_recipe_path(@recipe)
  end

  def update
    update_object(@recipe, recipe_params)
  end

  def new
    @recipe = Recipe.new

    breadcrumb 'Nieuw recept', new_recipe_path
  end

  def create
    recipe = Recipe.new(recipe_params)
    save_object(recipe)
  end

  def destroy
    delete_object(@recipe)
  end

  private

  def set_recipe
    @recipe ||= Recipe.find(params[:id])
  end
end
