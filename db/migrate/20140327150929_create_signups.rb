class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :status
      t.string :reason

      t.timestamps
    end
  end
end
