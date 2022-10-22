include Utils
ActiveAdmin.register Banner do

  index do
    selectable_column
    id_column
    column :active
    # column :image_url
    column :image_info
    column :device_type
    column :banner_image do |img|
      if img.banner_image.attached?
        get_asset_url(img.banner_image.key)
      else
        "NO IMAGE"
      end
    end
    actions
  end

  permit_params :active, :image_info, :banner_image, :device_type

  form do |f|
    # f.object.admin_user_id = current_admin_user.id
    f.inputs do
      f.input :active
      # f.input :image_url, as: :file
      f.input :image_info
      f.input :device_type
      f.input :banner_image, as: :file
    end
    f.actions
  end

  filter :active

  show do
    attributes_table do
      row :active
      # row :image_url
      row :image_info
      row :device_type
      row :banner_image do |img|
        if img.banner_image.attached?
          image_tag url_for(img.banner_image)
        end
      end
    end
  end

  controller do
    def destroy
      if resource.banner_image
        resource.banner_image.purge_later
      end
      super
    end
  end
end
