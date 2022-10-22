class ChangeWhatsappNumberInUserInfos < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_infos, :whatsapp_numner, :whatsapp_number
  end
end
