class AddEmailConfirmColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_confirmed, :boolean, :default => false
    add_column :users, :confirm_token, :string
    add_column :users, :confirm_mail_sent_at, :datetime
  end
end
