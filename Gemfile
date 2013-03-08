source 'https://rubygems.org'

gem 'rails', '3.2.6'
# gem 'mysql2', '0.3.11'
gem 'jquery-rails', '2.0.2'
gem 'yaml_db', '0.2.3'
gem 'cancan', '1.6.9'
gem 'devise', '2.2.3'
gem 'twitter', '4.5.0'
gem 'fb_graph', '2.6.4'
gem 'omniauth', '1.1.2'
gem 'omniauth-twitter', '0.0.14'
gem 'omniauth-facebook', '1.4.1'
gem 'andand', '1.3.3'
gem 'bootstrap-sass', '2.1.0.0'
gem 'formtastic'
gem 'paper_trail'
gem "sass", :require => 'sass'
gem 'paperclip'
gem 'net-sftp'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'
  gem 'spork', '0.9.2'
  gem 'faker', '1.0.1'
end

group :development do
  gem 'awesome_print', '1.1.0'
  gem 'wirble', '0.1.3'
  gem 'quiet_assets', '1.0.1'
  gem 'nifty-generators', '0.4.6'
  case RUBY_PLATFORM
  when /linux/
    gem 'unicorn-rails', '1.0.0'
  end
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'childprocess', '0.3.6'
  gem 'factory_girl_rails', '4.1.0'
  gem 'database_cleaner', '0.7.0'

  case RUBY_PLATFORM
  when /linux/
    gem 'rb-inotify', '0.8.8'
    gem 'libnotify', '0.5.9'
  else
    gem 'rb-fchange', '0.0.5'
    gem 'rb-notifu', '0.0.4'
    gem 'win32console'
  end
end
