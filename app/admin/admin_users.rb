ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :user_type_id, :enabled

  index do
    selectable_column
    id_column
    column :email
    column 'User type' do | admin_user |
      admin_user.user_type.user_type
    end
    column :enabled
    column :created_at
    actions
  end

  filter :email
  filter :user_type_id
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      if f.object.new_record? || current_admin_user.user_type.user_type == "super_admin"
        f.input :email
      end
      f.input :password
      f.input :password_confirmation
      f.input :enabled
      if f.object.new_record? || current_admin_user.user_type.user_type == "super_admin"
        f.input :user_type_id, label: 'User type', as: 'select', collection: UserType.user_types.keys.map{|x| [x, UserType.where(user_type: x)[0].id]}
      end
    end
    f.actions
  end

end
