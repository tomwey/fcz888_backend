class CreateLoanProductTracks < ActiveRecord::Migration
  def change
    create_table :loan_product_tracks do |t|
      t.integer :event_id
      t.integer :channel_id
      t.integer :product_id
      t.string :ip
      t.string :user_agent

      t.timestamps null: false
    end
    add_index :loan_product_tracks, :event_id
    add_index :loan_product_tracks, :channel_id
    add_index :loan_product_tracks, :product_id
  end
end
