# -*- encoding: utf-8 -*-
# stub: erb2slim 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "erb2slim".freeze
  s.version = "0.0.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Beomki Lee".freeze]
  s.date = "2012-08-22"
  s.description = "Converts Erb templates to Slim templates".freeze
  s.email = "c0untd0wn@wafflestudio.com".freeze
  s.homepage = "https://github.com/c0untd0wn/erb2slim".freeze
  s.rubygems_version = "1.8.24".freeze
  s.summary = "Erb to Slim Converter".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 3

  s.add_runtime_dependency(%q<haml>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<hpricot>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<erubis>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<haml2slim>.freeze, [">= 0".freeze])
end
