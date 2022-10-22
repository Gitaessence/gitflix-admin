class AddAdminUserIdToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :admin_user_id, :bigint
    add_index :categories, :admin_user_id
    add_foreign_key :categories, :admin_users
  end
end
