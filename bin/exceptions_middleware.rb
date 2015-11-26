class ExceptionsMiddleware
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      app.call(env)
    rescue Exception => e

      view_content = File.read("views/exceptions_middleware/exception.html.erb")
      body = ERB.new(view_content).result(binding)
      return_array = [500, {"Content-Type" => "text/html"}, [body]]
    end
  end
end
