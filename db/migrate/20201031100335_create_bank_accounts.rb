class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :account_type
      t.date :open_date
      t.integer :customer_id
      t.string :customer_name
      t.string :branch
      t.boolean :minor_indicator

      t.timestamps
    end
    execute "SELECT setval('bank_accounts_id_seq', 233550)"
  end
end
