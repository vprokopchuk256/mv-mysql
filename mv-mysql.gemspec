# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: mv-mysql 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mv-mysql"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Valeriy Prokopchuk"]
  s.date = "2015-01-13"
  s.description = "Migration Validators project mysql driver"
  s.email = "vprokopchuk@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/mv-mysql.rb",
    "lib/mv/mysql/active_record/connection_adapters/mysql_adapter_decorator.rb",
    "lib/mv/mysql/constraint/builder/trigger.rb",
    "lib/mv/mysql/railtie.rb",
    "lib/mv/mysql/validation/builder/trigger/exclusion.rb",
    "lib/mv/mysql/validation/builder/trigger/inclusion.rb",
    "lib/mv/mysql/validation/builder/trigger/length.rb",
    "lib/mv/mysql/validation/builder/trigger/mysql_datetime_values.rb",
    "lib/mv/mysql/validation/builder/trigger/presence.rb",
    "lib/mv/mysql/validation/builder/trigger/trigger_column.rb",
    "lib/mv/mysql/validation/builder/trigger/uniqueness.rb"
  ]
  s.homepage = "http://github.com/vprokopchuk256/mv-mysql"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.4"
  s.summary = "Migration Validators project. MySQL driver"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["~> 4.1"])
      s.add_runtime_dependency(%q<mysql2>, ["~> 0.3"])
      s.add_runtime_dependency(%q<mv-core>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.1"])
      s.add_development_dependency(%q<rspec-its>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<mv-test>, ["~> 1.0"])
    else
      s.add_dependency(%q<railties>, ["~> 4.1"])
      s.add_dependency(%q<mysql2>, ["~> 0.3"])
      s.add_dependency(%q<mv-core>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 3.1"])
      s.add_dependency(%q<rspec-its>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<mv-test>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<railties>, ["~> 4.1"])
    s.add_dependency(%q<mysql2>, ["~> 0.3"])
    s.add_dependency(%q<mv-core>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 3.1"])
    s.add_dependency(%q<rspec-its>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<mv-test>, ["~> 1.0"])
  end
end

