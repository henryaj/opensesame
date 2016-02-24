lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "api"

required_env_vars = %w(
  PARTICLE_ACCESS_TOKEN
  PARTICLE_DEVICE_NAME
  SECRET_CODE
)

required_env_vars.each do |name|
  raise "#{name} not set in environment" unless ENV[name]
end

run OpenSesame::API
