require 'json'
require 'byebug'

class Flash
  def initialize(req)
    if req.cookies.nil? || req.cookies["_flash"] == {} || req.cookies["_flash"] == "null"
      @flash_new = {}
      @flash_past = {}
    else
      @flash_past = JSON.parse(req.cookies["_flash"])
      @flash_new = {}
    end
  end

  def [](key)
      hash = @flash_new.merge(@flash_past)
      hash[key]
  end

  def now
    @flash_past
  end

  def []=(key, val)
    @flash_new[key] = val
  end

  def store_flash(res)
    res.set_cookie('_flash', {path: "/", value: @flash_new.to_json})
  end
end
