require_relative 'app'
require 'resque/server'

run Rack::URLMap.new({
  "/" => Cuba,
  "/resque" => Resque::Server.new 
})
