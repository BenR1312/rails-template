class LogoUploader < BaseUploader
  include CarrierWave::MiniMagick

  version :logo do 
    process resize_to_fit: [250, 250]
  end

  version :thumb do
    process resize_to_fill: [50,50]
  end

  def default_url
    "/assets/fallback/" + [version_name, "logo_placeholder.png"].compact.join('_')
  end
end
