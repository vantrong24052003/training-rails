# -*- encoding: utf-8 -*-
# stub: slim-rails 3.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "slim-rails".freeze
  s.version = "3.7.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Leonardo Almeida".freeze, "Janusz Mordarski".freeze]
  s.date = "2024-12-29"
  s.description = "Provides the generator settings required for Rails to use Slim".freeze
  s.email = ["lalmeida08@gmail.com".freeze, "janusz.m@gmail.com".freeze]
  s.homepage = "https://github.com/slim-template/slim-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.5.23".freeze
  s.summary = "Slim templates generator for Rails".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.1".freeze])
  s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1".freeze])
  s.add_runtime_dependency(%q<slim>.freeze, [">= 3.0".freeze, "!= 5.0.0".freeze, "< 6.0".freeze])
  s.add_development_dependency(%q<sprockets-rails>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<slim_lint>.freeze, [">= 0.24.0".freeze])
  s.add_development_dependency(%q<rocco>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<redcarpet>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<awesome_print>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<actionmailer>.freeze, [">= 3.1".freeze])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<standardrb>.freeze, [">= 0".freeze])
end
