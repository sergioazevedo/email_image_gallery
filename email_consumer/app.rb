require_relative './config/environment'
require_relative './config/routes'

# Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.plugin Cuba::Safe
