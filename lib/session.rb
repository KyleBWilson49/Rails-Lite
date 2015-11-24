require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    if req.cookies['_rails_lite_app']
      @cookie_attributes = JSON.parse(req.cookies['_rails_lite_app'])
    else
      @cookie_attributes = {}
    end
  end

  def [](key)
    @cookie_attributes[key]
  end

  def []=(key, val)
    @cookie_attributes[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    @cookie_attributes[:path] = "/"
    res.set_cookie('_rails_lite_app',
      @cookie_attributes.to_json
      )
  end
end
