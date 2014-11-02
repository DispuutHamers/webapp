class CreateMotions < ActiveRecord::Migration
  def change
    create_table :motions do |t|
      t.string :motion_type
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
