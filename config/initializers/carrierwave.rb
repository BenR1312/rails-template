# Save assets in another folder when testing
if defined?(CarrierWave) && Rails.env.test?
  BaseUploader.class_eval do
    def self.base_dir
      "#{Rails.root}/spec/support/uploads"
    end

    def cache_dir
      "#{self.class.base_dir}/tmp"
    end

    def store_dir
      "#{self.class.base_dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
end
