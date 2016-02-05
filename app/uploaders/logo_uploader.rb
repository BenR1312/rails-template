class LogoUploader < BaseUploader
  include CarrierWave::MiniMagick

  process resize_to_fit: [250, 250]

  version :thumb do
    process resize_to_fill: [50,50]
  end

  def default_url(*args)
    "default.png"
  end
end
