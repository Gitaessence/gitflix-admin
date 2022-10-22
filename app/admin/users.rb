ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :email, :remember_created_at, :enabled, :password, :email_confirmed

  index do
    selectable_column
    id_column
    column :email
    column :enabled
    column :email_confirmed
    actions
  end


  form do |f|
    f.inputs do
      f.input :email
      f.input :enabled
      f.input :password
      f.input :email_confirmed
      # f.input :password_confirmation
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :enabled, :jti]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
