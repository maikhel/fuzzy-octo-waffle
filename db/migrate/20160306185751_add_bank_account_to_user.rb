class AddBankAccountToUser < ActiveRecord::Migration
  def change
    add_column :users, :bank_account, :string
  end
end
