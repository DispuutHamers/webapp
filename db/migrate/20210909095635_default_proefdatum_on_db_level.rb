class DefaultProefdatumOnDbLevel < ActiveRecord::Migration[6.1]
  def change
    change_column_default :reviews, :proefdatum, -> { 'CURRENT_DATE' }
  end
end
