class AddRecipeAndChugToBeer < ActiveRecord::Migration[6.1]
  def change
    add_column :beers, :recipe_id, :integer
    add_column :beers, :chugtype_id, :integer
  end
end
