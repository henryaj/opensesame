require "grape"

require "door"

module OpenSesame
  class API < Grape::API
    format :json

    get "/status" do
      { status: "ok" }
    end

    post "/open" do
      error!("Not authorised", 401) unless params[:body] == "open sesame"

      OpenSesame::Door.open!

      { status: "ok" }
    end
  end
end
