class CreateUserInfo < ActiveRecord::Migration[7.0]
  def change
    create_table :user_infos do |t|
      # date of birth
      t.date :dob
      t.string :phone_number, :limit => 15
      t.string :whatsapp_numner, :limit => 15
      t.text :profile_photo_url
      t.references :user, null: false, foreign_key: true      
      t.integer :gender # male female other
 
      t.timestamps
    end

    create_table :user_addresses do |t|
      t.string :city
      t.string :state
      t.string :pincode, :limit => 10
      t.text :address

      t.timestamps
    end
  end
end
