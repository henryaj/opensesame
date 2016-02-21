require "particlerb"

module OpenSesame
  class Door
    attr_reader :device

    def initialize(device: default_device)
      @device = device
    end

    def open!
      device.call(:open_door)
    end

    private

    def default_device
      Particle.device(ENV.fetch("PARTICLE_DEVICE_NAME"))
    end
  end
end
