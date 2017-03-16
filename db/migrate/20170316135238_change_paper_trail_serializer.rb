class ChangePaperTrailSerializer < ActiveRecord::Migration[5.0]
  def change
    rename_column :versions, :object, :old_object
    add_column :versions, :object, :json
  end
end
