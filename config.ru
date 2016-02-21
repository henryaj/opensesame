lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "api"

unless ENV["PARTICLE_DEVICE_NAME"]
  raise "PARTICLE_DEVICE_NAME not set in environment"
end

run OpenSesame::API
