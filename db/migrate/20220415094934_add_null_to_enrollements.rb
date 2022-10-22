class AddNullToEnrollements < ActiveRecord::Migration[7.0]
  def change
    change_column :enrollements, :end_date, :datetime, null: true
  end
end
