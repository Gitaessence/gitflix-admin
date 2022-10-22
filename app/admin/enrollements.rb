ActiveAdmin.register Enrollement do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :progress, :course_completed, :start_date, :end_date, :user_id, :category_id

  form do |f|
    f.inputs do
      f.input :user_id, label: 'User', as: 'select', collection: User.all.map{|x| [x.email, x.id]}
      f.input :category_id, label: 'Category', as: 'select', collection: Category.all
      f.input :start_date, as: :datetime_picker
      f.input :end_date, as: :datetime_picker
      f.input :progress
      f.input :course_completed
    end
    f.actions
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:progress, :course_completed, :start_date, :end_date, :user_id, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
