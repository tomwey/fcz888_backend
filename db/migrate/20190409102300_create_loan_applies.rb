class CreateLoanApplies < ActiveRecord::Migration
  def change
    create_table :loan_applies do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :idcard, null: false
      t.string :money
      t.string :duration
      t.string :loan_type
      t.string :credit_status
      t.string :job
      t.string :salary_type
      t.string :salary
      t.string :work_length
      t.string :other_info

      t.timestamps null: false
    end
    add_index :loan_applies, :user_id
  end
end
