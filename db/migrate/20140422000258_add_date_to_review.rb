class AddDateToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :proefdatum, :date
  end
end
