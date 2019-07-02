class CreatePromoChannels < ActiveRecord::Migration
  def change
    create_table :promo_channels do |t|
      t.integer :uniq_id
      t.string :name
      t.string :mobile
      t.string :password_digest
      t.string :private_token
      t.boolean :opened, default: true

      t.timestamps null: false
    end
  end
end
