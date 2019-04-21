class CreatePromoPosters < ActiveRecord::Migration
  def change
    create_table :promo_posters do |t|
      t.string :uniq_id
      t.integer :product_id, null: false
      t.string :top_img
      t.string :bottom_img
      t.string :bg_color
      t.string :btn_text
      t.string :app_url
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :promo_posters, :product_id
    add_index :promo_posters, :uniq_id, unique: true
  end
end
