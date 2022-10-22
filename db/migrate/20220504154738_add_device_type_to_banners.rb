class AddDeviceTypeToBanners < ActiveRecord::Migration[7.0]
  def change
    add_column :banners, :device_type, :integer, :default => 0
  end
end