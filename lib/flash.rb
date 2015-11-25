require 'json'

class Flash
  attr_accessor :flash_attributes

  def initialize(req)
    if flash
      @flash_attributes = JSON.parse(req.cookies['_flash'])
    else
      @flash_attributes = {}
    end
  end

  def [](key)
    @flash_attributes[key]
  end

  def []=(key, val)
    @flash_attributes[key] = val
  end

  def store_flash(res)
    @flash_attributes[:path] = "/"
    res.set_cookie('_flash', @flash_attributes.to_json)
  end
end
