require 'rack'
require 'byebug'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  path = req.fullpath
  # debugger
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write(path)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
