class RemoveProefdatumDefault < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :proefdatum, :date, :default => nil
  end
end
