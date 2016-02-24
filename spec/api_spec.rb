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
    let(:door) { instance_double(OpenSesame::Door, open!: "door opened") }

    before do
      allow(ENV).to receive(:fetch).with("SECRET_CODE").and_return("open sesame")

      allow(OpenSesame::API).to receive(:logger).and_return(logger)
      allow(OpenSesame::Door).to receive(:new).and_return(door)

      post "/open", { "body" => "open sesame", "from" => "+12345" }
    end

    it "gets the door opening code from the environment" do
      expect(ENV).to have_received(:fetch).with("SECRET_CODE")
    end

    it "tells the door to open" do
      expect(door).to have_received(:open!)
    end

    it "requires authorisation" do
      post "/open", { "body" => "hello dave", "from" => "+12345" }

      expect(last_response.status).to eq(401)
    end

    it "logs the details of the attempt" do
      expect(logger).to have_received(:info).with(
        "Unlocking door for +12345..."
      )
    end

    describe "returning the status of the open command" do
      it "returns 'door opened' on success" do
        allow(door).to receive(:open!).and_return("door opened")

        post "/open", { "body" => "open sesame", "from" => "+12345" }

        expect(JSON.parse(last_response.body)).to eq(
          { "status" => "door opened" }
        )
      end

      it "returns 'error' on failure" do
        allow(door).to receive(:open!).and_return("error")

        post "/open", { "body" => "open sesame", "from" => "+12345" }

        expect(JSON.parse(last_response.body)).to eq(
          { "status" => "error" }
        )
      end
    end
  end
end
