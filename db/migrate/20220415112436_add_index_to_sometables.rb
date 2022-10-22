class AddIndexToSometables < ActiveRecord::Migration[7.0]
  def change
    add_column :user_infos, :name, :string
  end
end
