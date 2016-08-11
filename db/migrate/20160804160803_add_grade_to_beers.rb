class AddGradeToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :grade, :double
  end
end
