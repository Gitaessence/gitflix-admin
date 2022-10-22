class CreateEnrollement < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollements do |t|
      t.integer :progress, default: 0
      t.boolean :course_completed, default: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    create_table :banners do |t|
      t.boolean :active, default: false
      t.text :image_url
      t.string :image_info
      
      t.timestamps
    end
  end
end
