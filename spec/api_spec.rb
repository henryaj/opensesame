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
    let(:logger) { double("logger", info: nil) }
    let(:door) { instance_double(OpenSesame::Door, open!: nil) }

    before do
      allow(OpenSesame::API).to receive(:logger).and_return(logger)
      allow(OpenSesame::Door).to receive(:new).and_return(door)

      post "/open", { "body" => "open sesame", "from" => "+12345" }
    end

    it "tells the door to open" do
      expect(door).to have_received(:open!)
    end

    it "returns 200 OK" do
      expect(JSON.parse(last_response.body)).to eq(
        {"status" => "ok"}
      )
    end

    it "requires authorisation" do
      post "/open", { "body" => "hello dave", "from" => "+12345" }

      expect(last_response.status).to eq(401)
    end

    it "logs the details of the request" do
      expect(logger).to have_received(:info).with(
        "Unlocked door for +12345"
      )
    end
  end
end
