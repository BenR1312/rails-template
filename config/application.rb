require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TfgTemplate
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app', 'authorization', 'params')
    config.autoload_paths << Rails.root.join('app', 'authorization', 'policies')
    config.autoload_paths << Rails.root.join('app', 'authorization', 'scopes')

    config.should_seed_application_data = false
    config.should_show_easy_login = false
  end
end
