class CreateUsergroups < ActiveRecord::Migration
  def change
    create_table :usergroups do |t|

      t.timestamps
    end
  end
end
