require 'rack/auth/krb/basic_and_nego'

infinity = Proc.new {|env|
  [200,
    {
      "Content-Type" => "text/html"},
      [
        "Hello #{env['REMOTE_USER']}"
      ]
  ]
}

use Rack::Session::Cookie
use Rack::Logger, ::Logger::DEBUG
use Rack::Auth::Krb::BasicAndNego,
    'EXAMPLE.COM',
    ENV['KEYTAB_LOCATION'],
    # Not sure why we have to provide the service here but it wasn't deriving it correctly on its own
    'HTTP/webserver@EXAMPLE.COM'

map '/' do
  run infinity
end
