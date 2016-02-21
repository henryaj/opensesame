require "grape"

require "door"

module OpenSesame
  class API < Grape::API
    format :json

    helpers do
      def logger
        API.logger
      end
    end

    get "/status" do
      { status: "ok" }
    end

    post "/open" do
      error!("Not authorised", 401) unless params[:body] == "open sesame"

      OpenSesame::Door.new.open!
      API.logger.info "Unlocked door for #{params[:from]}"

      { status: "ok" }
    end
  end
end
