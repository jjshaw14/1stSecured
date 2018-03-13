source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'pg', '~> 0.18'
gem 'pg_search'

gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby

gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'

gem 'canable'
gem 'devise'
gem 'omniauth-google-oauth2'

gem 'carrierwave', '~> 1.0'
gem 'carrierwave-base64'
gem 'httparty'
gem 'fog-aws'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem 'redcarpet'

gem 'webpacker', require: false

gem 'paper_trail'

gem 'sendgrid'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  gem 'dotenv-rails'

  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
