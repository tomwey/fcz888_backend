class AddIndexToPromoChannels < ActiveRecord::Migration
  def change
    add_index :promo_channels, :uniq_id, unique: true
  end
end
