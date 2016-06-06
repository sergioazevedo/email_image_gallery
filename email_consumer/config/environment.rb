require 'rubygems'
require 'bundler'
Bundler.require(:default, :development)
require 'cuba/safe'

# Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.plugin Cuba::Safe
