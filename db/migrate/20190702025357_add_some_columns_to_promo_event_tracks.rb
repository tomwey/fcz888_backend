class AddSomeColumnsToPromoEventTracks < ActiveRecord::Migration
  def change
    add_column :promo_event_tracks, :device, :string
    add_column :promo_event_tracks, :os, :string
    add_column :promo_event_tracks, :os_version, :string
  end
end
