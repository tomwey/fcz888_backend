class AddFromChnIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :from_chn_id, :integer
    add_index :users, :from_chn_id
  end
end
