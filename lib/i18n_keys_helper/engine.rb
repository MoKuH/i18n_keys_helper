module I18nKeysHelper
  class Engine < Rails::Engine
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    initializer :assets do |app|
      app.config.assets.precompile += %w( translate.js translate.css)
    end
  end
end