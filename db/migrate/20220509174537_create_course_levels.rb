class CreateCourseLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :course_levels do |t|
      t.string :name

      t.timestamps
    end

    add_column :categories, :course_level_id, :bigint
    add_index :categories, :course_level_id
    add_foreign_key :categories, :course_levels
  end
end
