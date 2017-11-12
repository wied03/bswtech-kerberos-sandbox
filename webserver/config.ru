require 'rack/auth/krb/basic_and_nego'

infinity = Proc.new {|env| [200, {"Content-Type" => "text/html"}, ["Hello #{env['REMOTE_USER']}"]]}

use Rack::Session::Cookie
use Rack::Logger, ::Logger::DEBUG
use Rack::Auth::Krb::BasicAndNego,
    'EXAMPLE.COM',
    ENV['KEYTAB_LOCATION']

map '/' do
  run infinity
end
