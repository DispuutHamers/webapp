class CreateDrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :drafts do |t|
      t.references :entity, polymorphic: true, index: true
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
