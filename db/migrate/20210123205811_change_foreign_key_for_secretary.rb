class ChangeForeignKeyForSecretary < ActiveRecord::Migration[6.0]
  def change
    rename_column :meetings, :user_id, :secretary_id
  end
end
