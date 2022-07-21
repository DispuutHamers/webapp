class AddChugsAndChugtype < ActiveRecord::Migration[6.1]
  def change
    create_table :chugs do |t|
      t.references :chugtype, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :secs, null: false, default: 0
      t.integer :milis, null: false, default: 0
      t.string :comment, default: nil
      t.timestamps
    end

    create_table :chugtypes do |t|
      t.string :name, null: false
      t.integer :amount, null: false, default: 0
      t.timestamps
    end
  end
end
