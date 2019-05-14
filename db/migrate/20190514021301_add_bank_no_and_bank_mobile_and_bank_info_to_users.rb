class AddBankNoAndBankMobileAndBankInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bank_no, :string
    add_column :users, :bank_mobile, :string
    add_column :users, :bank_info, :text
  end
end
