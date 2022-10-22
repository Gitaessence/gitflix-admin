class CreateTestimonials < ActiveRecord::Migration[7.0]
  def change
    create_table :testimonials do |t|
      t.text :author_image
      t.string :author_name
      t.text :details
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
