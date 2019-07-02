class CreatePromoEvents < ActiveRecord::Migration
  def change
    create_table :promo_events do |t|
      t.integer :uniq_id
      t.string :name
      t.integer :channel_ids, array: true, default: []
      t.integer :promo_template_id
      t.integer :promo_product_ids, array: true, default: []
      t.integer :view_count, default: 0
      t.integer :take_count, default: 0
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :promo_events, :promo_template_id
    add_index :promo_events, :uniq_id, unique: true
    add_index :promo_events, :channel_ids, using: 'gin'
    add_index :promo_events, :promo_product_ids, using: 'gin'
  end
end
