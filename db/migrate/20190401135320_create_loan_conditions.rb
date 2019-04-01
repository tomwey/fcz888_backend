class CreateLoanConditions < ActiveRecord::Migration
  def change
    create_table :loan_conditions do |t|
      t.string :icon
      t.string :name, null: false
      t.integer :sort, default: 0

      t.timestamps null: false
    end
  end
end
