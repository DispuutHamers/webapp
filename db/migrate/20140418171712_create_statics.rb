class CreateStatics < ActiveRecord::Migration
  def change
    create_table :statics do |t|
      t.string :title
      t.string :content
      t.string :p_content

      t.timestamps
    end
  end
end
