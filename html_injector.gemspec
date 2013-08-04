# -*- encoding: utf-8 -*-
require File.expand_path('../lib/html_injector/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Juan de Dios Herrero']
  gem.email         = ['juandediosherrero@gmail.com']
  gem.description   = %q{Simple gem to inject html blocks into already existent html files}
  gem.summary       = %q{}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'html_injector'
  gem.require_paths = ['lib']
  gem.version       = HtmlInjector::VERSION
  gem.add_runtime_dependency 'nokogiri', '~> 1.6.0'
end
