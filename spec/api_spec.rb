require "rack/test"

require "api"
require "door"

describe OpenSesame::API do
  include Rack::Test::Methods

  def app
    OpenSesame::API
  end

  describe "/status" do
    it "returns the API status" do
      get "/status"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).to eq(
        {"status" => "ok"}
      )
    end
  end

  describe "/open" do
    before do
      allow(OpenSesame::Door).to receive(:open!)
      post "/open", { "body" => "open sesame" }
    end

    it "tells the door to open" do
      expect(OpenSesame::Door).to have_received(:open!)
    end

    it "returns 200 OK" do
      expect(JSON.parse(last_response.body)).to eq(
        {"status" => "ok"}
      )
    end

    it "requires authorisation" do
      post "/open", { "body" => "hello dave" }

      expect(last_response.status).to eq(401)
    end

    xit "logs the details of the request"
  end
end
