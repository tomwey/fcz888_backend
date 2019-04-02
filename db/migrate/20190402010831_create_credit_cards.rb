class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :bank_id, null: false
      t.string :cover, null: false
      t.string :name, null: false
      t.string :intro
      t.string :special
      t.string :apply_url, null: false
      t.integer :view_count, default: 0
      t.integer :sort, default: 0
      t.integer :apply_count, default: 0
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :credit_cards, :bank_id
    add_index :credit_cards, :view_count
    add_index :credit_cards, :sort
    add_index :credit_cards, :apply_count
  end
end
