include Utils
ActiveAdmin.register UserInfo do

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :user_address
    column :dob
    column :phone_number
    column :whatsapp_number
    column :gender
    column :user_avatar do |img|
      if img.user_avatar.attached?
        get_asset_url(img.user_avatar.key)
        # "#{ENV['BUCKET_BASE_URL']}#{ENV['BUCKET_NAME']}/#{img.user_avatar.key}"
      else
        "NO IMAGE"
      end
    end
    actions
  end

  permit_params :name, :dob, :phone_number, :whatsapp_number, :profile_photo_url, :user_id, :gender, :user_address_id, :user_avatar

  form do |f|
    f.inputs do
      f.input :name
      f.input :user_id, label: 'User', as: 'select', collection: User.all.map{|x| [x.email, x.id]}
      f.input :user_address_id, label: 'User address', as: 'select', collection: UserAddress.all.map{|x| [x.id, x.id]}, require: false
      f.input :dob, as: :date_picker, 
                        date_picker_options: {
                          min_date: '1970-01-01',
                          max_date: '2020-01-01'
                        }, :input_html => {:class => 'hasDatePicker'}
      f.input :phone_number
      f.input :whatsapp_number
      # f.input :profile_photo_url
      f.input :user_avatar, as: :file
      f.input :gender
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :user
      row :user_address
      row :dob
      row :phone_number
      row :whatsapp_number
      row :gender
      # row :author_image
      row :user_avatar do |img|
        if img.user_avatar.attached?
          image_tag url_for(img.user_avatar)
        end
      end
    end
  end
  
  controller do
    def destroy
      if resource.user_avatar
        resource.user_avatar.purge_later
      end
      super
    end
  end  
end
