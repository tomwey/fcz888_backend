class CreatePromoTemplates < ActiveRecord::Migration
  def change
    create_table :promo_templates do |t|
      t.string :name
      t.string :image
      # t.boolean :need_login, default: false

      t.timestamps null: false
    end
  end
end
