class AddDefaultValueToUserApprovedAttribute < ActiveRecord::Migration[5.0]
def up
    change_column :users, :approved, :boolean, :default => false
end

def down
    change_column :users, :approved, :boolean, :default => nil
end
end
