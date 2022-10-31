class AddReporterToChugs < ActiveRecord::Migration[6.1]
  def change
    add_column :chugs, :reporter_id, :integer
  end
end
