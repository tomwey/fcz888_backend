class CreateLoanSpeeds < ActiveRecord::Migration
  def change
    create_table :loan_speeds do |t|
      t.string :name, null: false, default: ''
      t.integer :score, null: false
      t.boolean :opened, default: true
      
      t.timestamps null: false
    end
  end
end
