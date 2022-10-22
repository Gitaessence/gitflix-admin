class AddEnabledToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :enabled, :boolean, default: true
  end
end
