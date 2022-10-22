class AddAuthorToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :author_name, :string
    add_column :categories, :author_image, :text
    add_column :categories, :about_author, :text
    add_column :categories, :course_image, :text
    add_column :categories, :age_criteria, :integer
    add_column :categories, :start_date, :date
    add_column :categories, :end_date, :date
    add_column :categories, :total_duration, :integer
    add_column :categories, :is_free, :boolean
    add_column :categories, :is_paid, :boolean
  end
end
