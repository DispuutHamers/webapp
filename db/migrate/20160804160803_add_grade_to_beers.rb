class AddGradeToBeers < ActiveRecord::Migration[5.0]
def change
    add_column :beers, :grade, :double
  end
end
