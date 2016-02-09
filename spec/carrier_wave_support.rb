RSpec.configure do |config|

  config.before(:all) do
    # Specs run significantly faster with processing off
    BaseUploader.enable_processing = false
  end

  config.after(:all) do
    BaseUploader.enable_processing = true

    uploaded_files_path = BaseUploader.store_dir
    FileUtils.rm_r(uploaded_files_path) if File.exists?(uploaded_files_path)
  end

end
