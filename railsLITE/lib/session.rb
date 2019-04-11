require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    parsed = req.cookies
    @cookies = parsed["_rails_lite_app"] ? JSON.parse(parsed["_rails_lite_app"]) : {}
  end

  def [](key)
    @cookies[key]
  end

  def []=(key, val)
    @cookies[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie("_rails_lite_app", path: "/", value: JSON.generate(@cookies))
  end
end
