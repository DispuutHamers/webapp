class ChangeQuoteReporterColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :quotes, :reporter, :reporter_id
  end
end
