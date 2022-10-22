class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :details
      t.text :image_url
      t.text :content_url
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
