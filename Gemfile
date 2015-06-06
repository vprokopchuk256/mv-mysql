source "http://rubygems.org"

gem 'railties', '~> 4.1'
gem 'mysql2', '~> 0.3'
# gem "mv-core", '~> 2.2'
gem 'mv-core', git: 'https://github.com/vprokopchuk256/mv-core.git', branch: 'predefined_formats'


group :development do
  gem "jeweler", '~> 2.0'
  gem "rspec", '~> 3.1'
  gem 'rspec-its', '~> 1.1'
  gem 'guard-rspec', '~> 4.5', require: false
  gem 'mv-test', '~> 1.0'
end

group :test do
  gem 'pry-byebug'
  gem 'coveralls', require: false
  gem 'rb-fsevent'
  gem 'terminal-notifier-guard'
end

