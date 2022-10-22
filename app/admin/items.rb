include Utils
ActiveAdmin.register Item do

  index do
    selectable_column
    id_column
    column :name
    column :details
    column :content_url
    column :category
    column :item_image do |img|
      if img.item_image.attached?
        get_asset_url(img.item_image.key)
        # "#{ENV['BUCKET_BASE_URL']}#{ENV['BUCKET_NAME']}/#{img.item_image.key}"
      else
        "NO IMAGE"
      end
    end
    actions
  end

  permit_params :name, :details, :content_url, :category_id, :item_image
  
  form do |f|
    f.inputs do
      f.input :category #_id, label: 'Category', as: 'select', collection: Category.where(admin_user_id: current_admin_user.id)
      f.input :name
      f.input :details
      f.input :item_image, as: :file
      f.input :content_url
    end
    f.actions
  end  

  show do
    attributes_table do
      row :name
      row :details
      row :content_url
      row :category
      row :item_image do |img|
        if img.item_image.attached?
          image_tag url_for(img.item_image)
        end
      end
    end
  end  

  controller do
    def destroy
      if resource.item_image
        resource.item_image.purge_later
      end
      super
    end
  end  
end
