include Utils
ActiveAdmin.register Testimonial do

  index do
    selectable_column
    id_column
    column :author_name
    # column :author_image
    column :details
    column :active
    column :author_avatar do |img|
      if img.author_avatar.attached?
        get_asset_url(img.author_avatar.key)
        # "#{ENV['BUCKET_BASE_URL']}#{ENV['BUCKET_NAME']}/#{img.author_avatar.key}"
      else
        "NO IMAGE"
      end
    end
    actions
  end

  permit_params :author_image, :author_name, :details, :active, :author_avatar
  
  form do |f|
    # f.object.admin_user_id = current_admin_user.id
    f.inputs do
      f.input :author_name
      f.input :active
      f.input :details
      # f.input :author_image
      f.input :author_avatar, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :author_name
      # row :author_image
      row :active
      row :details
      row :author_avatar do |img|
        if img.author_avatar.attached?
          image_tag url_for(img.author_avatar)
        end
      end
    end
  end

  controller do
    def destroy
      if resource.author_avatar
        resource.author_avatar.purge_later
      end
      super
    end
  end
end
