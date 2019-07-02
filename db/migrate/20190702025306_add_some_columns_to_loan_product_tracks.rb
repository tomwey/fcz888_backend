class AddSomeColumnsToLoanProductTracks < ActiveRecord::Migration
  def change
    add_column :loan_product_tracks, :device, :string
    add_column :loan_product_tracks, :os, :string
    add_column :loan_product_tracks, :os_version, :string
  end
end
