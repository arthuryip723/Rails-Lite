require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = req.cookies.find do |cookie|
        cookie.name == "_rails_lite_app"
      end

      @cookies = cookie ? JSON.parse(cookie.value) : {}

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
      res.cookies << WEBrick::Cookie.new("_rails_lite_app", @cookies.to_json)
    end
  end
end
