# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_keys_helper/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n_keys_helper"
  spec.version       = I18nKeysHelper::VERSION
  spec.authors       = ["Jean-Baptiste Bernard, Ruby Developer"]
  spec.email         = ["jeanbaptiste.bernard.wm@gmail.com"]
  spec.summary       = %q{ i18n_keys_helper allows you to display translation keys directly on your browser}
  spec.description   = %q{Move your mouse on the specifique text, image ..., and a tooltip containing the translation key is showed}
  spec.homepage      = "https://www.linkedin.com/in/jbbernard"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib","app/helpers","app/assets/javascripts","app/assets/stylesheets"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "i18n"
  spec.add_dependency "railties"

end
