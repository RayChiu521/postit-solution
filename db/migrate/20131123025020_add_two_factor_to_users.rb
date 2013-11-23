class AddTwoFactorToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :pin, :string, default: nil
  	add_column :users, :phone, :string, default: nil
  end
end
