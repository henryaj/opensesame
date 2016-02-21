require "grape"

require "door"

module OpenSesame
  class API < Grape::API
    format :json

    get "/status" do
      { status: "ok" }
    end

    get "/open" do
      OpenSesame::Door.open!

      { status: "ok" }
    end
  end
end
