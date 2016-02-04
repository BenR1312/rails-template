# Save assets in another folder when testing
if defined?(CarrierWave) && Rails.env.test?
  CarrierWave.configure do |config|
    # CarrierWave's processing slows down the test suite considerably so we disable it
    config.enable_processing = false
  end

  BaseUploader.class_eval do
    def cache_dir
      "#{Rails.root}/public/test_assets/uploads"
    end

    def store_dir
      "#{Rails.root}/public/test_assets/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
