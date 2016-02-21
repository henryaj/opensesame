require "airborne"

require "api"

Airborne.configure do |config|
  config.rack_app = OpenSesame::API
end

describe OpenSesame::API do
  describe "/status" do
    it "returns the API status" do
      get '/status'

      expect_json(status: "ok")
    end
  end
end
