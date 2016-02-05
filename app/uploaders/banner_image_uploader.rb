class BannerImageUploader < BaseUploader
  include CarrierWave::MiniMagick

  process resize_to_fit: [800, 100]

  def default_url
    "default.png"
  end
end
