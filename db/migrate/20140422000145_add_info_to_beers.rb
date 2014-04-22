class AddInfoToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :percentage, :string
    add_column :beers, :brewer, :string
    add_column :beers, :country, :string
  end
end
