class RemoveUserTypeIfFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user_type_id, :integer
  end
end
