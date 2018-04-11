class ChangePaperTrailSerializer < ActiveRecord::Migration[5.0]
  def change
    rename_column :versions, :object, :old_object
    add_column :versions, :object, :json
    rename_column :versions, :object_changes, :old_object_changes
    add_column :versions, :object_changes, :json
  end
end
