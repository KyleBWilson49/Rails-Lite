require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @already_built_response = false
    @req = req
    @res = res
    @route_params = route_params
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise Exception if already_built_response?

    res['Location'] = url
    res.status = 302
    @already_built_response = true
    res.finish
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise Exception if already_built_response?

    res['Content-Type'] = content_type
    res.write(content)
    @already_built_response = true
    res.finish
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.to_s.underscore
    view_content = File.read("views/#{controller_name}/#{template_name}.html.erb")

    content = ERB.new(view_content).result(binding)

    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end
