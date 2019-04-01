class AddConditionsToLoanProducts < ActiveRecord::Migration
  def change
    add_column :loan_products, :conditions, :integer, array: true, default: []
    add_index :loan_products, :conditions, using: :gin
  end
end
