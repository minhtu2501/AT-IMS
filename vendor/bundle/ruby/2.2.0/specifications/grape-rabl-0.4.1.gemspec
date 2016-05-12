# -*- encoding: utf-8 -*-
# stub: grape-rabl 0.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-rabl".freeze
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Nie\u{142}acny".freeze]
  s.date = "2015-08-03"
  s.description = "Use rabl in grape".freeze
  s.email = ["piotr.nielacny@gmail.com".freeze]
  s.homepage = "https://github.com/LTe/grape-rabl".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Use rabl in grape".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<grape>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rabl>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<tilt>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<i18n>.freeze, [">= 0"])
    else
      s.add_dependency(%q<grape>.freeze, [">= 0"])
      s.add_dependency(%q<rabl>.freeze, [">= 0"])
      s.add_dependency(%q<tilt>.freeze, [">= 0"])
      s.add_dependency(%q<i18n>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<grape>.freeze, [">= 0"])
    s.add_dependency(%q<rabl>.freeze, [">= 0"])
    s.add_dependency(%q<tilt>.freeze, [">= 0"])
    s.add_dependency(%q<i18n>.freeze, [">= 0"])
  end
end
