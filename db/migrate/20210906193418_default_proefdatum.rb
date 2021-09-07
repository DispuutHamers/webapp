class DefaultProefdatum < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :proefdatum, :date, :default => Date.today
  end
end
