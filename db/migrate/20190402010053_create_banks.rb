class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :icon, null: false
      t.string :name, null: false
      t.string :phone
      t.string :products_url
      t.string :home_url
      t.integer :sort, default: 0

      t.timestamps null: false
    end
    add_index :banks, :sort
  end
end
