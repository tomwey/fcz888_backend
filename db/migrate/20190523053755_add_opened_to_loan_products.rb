class AddOpenedToLoanProducts < ActiveRecord::Migration
  def change
    add_column :loan_products, :opened, :boolean, default: true
  end
end
