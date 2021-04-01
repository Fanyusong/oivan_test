# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

if Rails.env.production?
  use Rack::Rewrite do
    rewrite %r{^(?!.*(api|\.)).*$}, '/index.html'
  end
end

run Rails.application
Rails.application.load_server
