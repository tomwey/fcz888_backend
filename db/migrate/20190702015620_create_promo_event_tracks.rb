class CreatePromoEventTracks < ActiveRecord::Migration
  def change
    create_table :promo_event_tracks do |t|
      t.integer :promo_event_id
      t.integer :promo_channel_id
      t.string :action
      t.string :ip
      t.string :user_agent

      t.timestamps null: false
    end
    add_index :promo_event_tracks, :promo_event_id
    add_index :promo_event_tracks, :promo_channel_id
  end
end
