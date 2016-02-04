
module FileUploadSupport

  def sample_upload_file
    File.join(Rails.root, 'spec', 'support', 'company', 'banner_placeholder.png')
  end

end
