require "grape"

module OpenSesame
  class API < Grape::API
    format :json

    get "/status" do
      { status: "ok" }
    end
  end
end
