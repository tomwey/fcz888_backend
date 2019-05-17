class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :uniq_id
      t.string :name, null: false
      t.integer :poster_id
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :channels, :uniq_id, unique: true
  end
end
