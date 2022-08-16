class AddChugsAndChugtype < ActiveRecord::Migration[6.1]
  def change
    create_table :chugs do |t|
      t.integer :chugtype_id, null: false, foreign_key: true
      t.integer :user_id, null: false, foreign_key: true
      t.float :time, null: false, default: 0.0
      t.string :comment, default: nil
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end

    create_table :chugtypes do |t|
      t.string :name, null: false
      t.integer :amount, null: false, default: 0
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end
  end
end
