class CreateExternalSignups < ActiveRecord::Migration[6.0]
  def change
    create_table :external_signups do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :note
      t.integer :event_id, foreign_key: true

      t.timestamps
    end
  end
end
