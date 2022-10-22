class RemoveColumnFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :user_id, :bigint
  end
end
