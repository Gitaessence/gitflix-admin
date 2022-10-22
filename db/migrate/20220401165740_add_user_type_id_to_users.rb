class AddUserTypeIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_type_id, :integer
    add_index :users, :user_type_id
  end
end
