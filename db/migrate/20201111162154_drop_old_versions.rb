class DropOldVersions < ActiveRecord::Migration[6.0]
  def change
    PaperTrail::Version.where(item_type: "Device").delete_all
  end
end
