source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'

gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'

gem 'devise-i18n'
gem 'rails-i18n', '~> 6.0.0'

group :production do
  gem 'pg'
end

group :development do
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
end
