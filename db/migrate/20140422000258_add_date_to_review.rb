class AddDateToReview < ActiveRecord::Migration[5.0]
def change
    add_column :reviews, :proefdatum, :date
  end
end
