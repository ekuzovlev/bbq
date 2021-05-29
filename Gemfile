source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'

gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'

gem 'devise-i18n'
gem 'omniauth'
gem 'omniauth-facebook'
gem "omniauth-rails_csrf_protection"
gem 'omniauth-vkontakte'

gem 'high_voltage', '~> 3.1'

gem 'rails-i18n', '~> 6.0.0'

gem 'carrierwave', '~> 2.0'
gem 'rmagick'

gem 'fog-aws'

gem 'dotenv-rails'
gem 'mailjet'

gem 'recaptcha'

gem 'pundit'
group :production do
  gem 'pg'
end

group :development do
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
  gem "letter_opener"
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 4.0'
end
