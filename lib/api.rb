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

      API.logger.info "Unlocking door for #{params[:from]}..."
      status = OpenSesame::Door.new.open!

      { status: status }
    end
  end
end
