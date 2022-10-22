class AddReferencesToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :admin_users, :user_type, null: false, foreign_key: true
  end
end
