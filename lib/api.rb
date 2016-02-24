require "grape"

require "door"

module OpenSesame
  class API < Grape::API
    format :json

    helpers do
      def logger
        API.logger
      end

      def secret_code
        ENV.fetch("SECRET_CODE")
      end
    end

    get "/status" do
      { status: "ok" }
    end

    post "/open" do
      unless params[:body] == secret_code
        error!("Not authorised", 401)
      end

      API.logger.info "Unlocking door for #{params[:from]}..."
      status = OpenSesame::Door.new.open!

      { status: status }
    end
  end
end
