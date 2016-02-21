require "airborne"

require "api"
require "door"

Airborne.configure do |config|
  config.rack_app = OpenSesame::API
end

describe OpenSesame::API do
  describe "/status" do
    it "returns the API status" do
      get "/status"

      expect_json(status: "ok")
    end
  end

  describe "/open" do
    before do
      allow(OpenSesame::Door).to receive(:open!)
    end

    it "tells the door to open" do
      expect(OpenSesame::Door).to receive(:open!)

      get "/open"
    end

    it "returns 200 OK" do
      get "/open"

      expect_json(status: "ok")
      expect_status(200)
    end

    xit "requires authorisation"
    xit "logs the details of the request"
  end
end
