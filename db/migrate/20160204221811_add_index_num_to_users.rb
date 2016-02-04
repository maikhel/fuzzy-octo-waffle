class AddIndexNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :index_num, :string
    add_index :users, :index_num, unique: true
  end
end
