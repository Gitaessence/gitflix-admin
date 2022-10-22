module Utils
  def get_asset_url(asset_key)
    storage_service = Rails.configuration.active_storage.service

    if asset_key
      if storage_service == "amazon"
        return "#{ENV['AWS_BUCKET_BASE_URL']}/#{asset_key}"
      elsif storage_service == "google" || storage_service == "google_dev"
        return "#{ENV['BUCKET_BASE_URL']}#{ENV['BUCKET_NAME']}/#{asset_key}"
      end
    else
      return ""
    end
  end
end