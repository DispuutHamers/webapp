class CreateEmails < ActiveRecord::Migration[5.0]
def change
    create_table :emails do |t|
      t.string :from
      t.string :to
      t.text :body

      t.timestamps null: false
    end
  end
end
