include Utils
ActiveAdmin.register Category do
  
  index do
    selectable_column
    id_column
    column :name
    column :details
    column :enabled
    column :author_name
    column :about_author
    column :age_criteria
    column :start_date
    column :end_date
    column :total_duration
    column :is_free
    column :is_paid
    column :admin_user
    column :course_level

    column :author_avatar do |img|
      if img.author_avatar.attached?
        get_asset_url(img.author_avatar.key)
        # "#{ENV['BUCKET_BASE_URL']}#{ENV['BUCKET_NAME']}/#{img.author_avatar.key}"
      else
        "NO IMAGE"
      end
    end

    column :category_image do |img|
      if img.category_image.attached?
        get_asset_url(img.category_image.key)
        # "#{ENV['BUCKET_BASE_URL']}#{ENV['BUCKET_NAME']}/#{img.category_image.key}"
      else
        "NO IMAGE"
      end
    end
    actions
  end

  permit_params :name, :details, :enabled, :author_name, :about_author, :age_criteria, :start_date, :end_date, :total_duration, :is_free, :is_paid, :admin_user_id, :author_avatar, :category_image, :course_level_id
  
  form do |f|
    # f.object.admin_user_id = current_admin_user.id
    f.inputs do
      if f.object.new_record?
        f.input :admin_user_id, label: 'Admin User', as: 'select', collection: [[current_admin_user.email ,current_admin_user.id]]
      end
      f.input :course_level
      f.input :name
      f.input :details
      f.input :enabled
      f.input :author_name
      # f.input :author_image
      f.input :about_author
      # f.input :course_image
      f.input :age_criteria
      f.input :start_date, as: :date_picker, :input_html => {:class => 'hasDatePicker'}
      f.input :end_date, as: :date_picker, :input_html => {:class => 'hasDatePicker'}
      f.input :total_duration
      f.input :is_free
      f.input :is_paid
      f.input :author_avatar, as: :file
      f.input :category_image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :details
      row :enabled
      row :author_name
      row :about_author
      row :age_criteria
      row :start_date
      row :end_date
      row :total_duration
      row :is_free
      row :is_paid
      row :admin_user
      row :course_level

      row :author_avatar do |img|
        if img.author_avatar.attached?
          image_tag url_for(img.author_avatar)
        end
      end

      row :category_image do |img|
        if img.category_image.attached?
          image_tag url_for(img.category_image)
        end
      end
    end
  end

  controller do
    def destroy
      if resource.author_avatar
        resource.banner_image.purge_later
      end

      if resource.category_image
        resource.category_image.purge_later
      end

      super
    end
  end  
end
