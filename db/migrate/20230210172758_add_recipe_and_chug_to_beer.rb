class AddRecipeAndChugToBeer < ActiveRecord::Migration[6.1]
  def change
    add_column :beers, :recipe, :integer
    add_column :beers, :chug, :integer
  end
end
