class AddUserAddressIdToUserInfo < ActiveRecord::Migration[7.0]
  def change    
    add_column :user_infos, :user_address_id, :bigint
    add_index :user_infos, :user_address_id
    add_foreign_key :user_infos, :user_addresses
  end
end
