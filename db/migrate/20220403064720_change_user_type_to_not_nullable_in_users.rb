class ChangeUserTypeToNotNullableInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_type_id, :integer, null: false
  end
end
