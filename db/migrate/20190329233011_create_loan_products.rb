class CreateLoanProducts < ActiveRecord::Migration
  def change
    create_table :loan_products do |t|
      t.integer :uniq_id
      t.string :name, null: false, default: ''
      t.string :logo, null: false
      t.integer :min_money, null: false
      t.integer :max_money, null: false
      t.integer :min_length, null: false
      t.integer :max_length, null: false
      t.integer :length_type, null: false
      t.string :intro
      t.integer :speed
      t.integer :tags, array: true, default: []
      t.string :pass_rate
      t.string :loan_rate
      t.integer :loan_rate_type
      t.string :body_url
      t.text :body
      t.integer :view_count, default: 0
      t.integer :order_count, default: 0
      t.datetime :opened_at
      t.datetime :deleted_at
      t.integer :sort, default: 0

      t.timestamps null: false
    end
    add_index :loan_products, :uniq_id, unique: true
    add_index :loan_products, :sort
    add_index :loan_products, :speed
    add_index :loan_products, :tags, using: :gin
  end
end
