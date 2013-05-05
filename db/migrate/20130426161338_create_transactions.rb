class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description
      t.integer :debit_account_id
      t.integer :credit_account_id
      t.decimal :amount

      t.timestamps
    end
  end
end
