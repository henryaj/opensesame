require "door"

describe OpenSesame::Door do
  describe "#open" do
    let(:particle) { class_double(Particle, device: device) }
    let(:device) { instance_double(Particle::Device, call: nil) }
    let(:door) { OpenSesame::Door.new(device: device)}

    it "instructs the Particle to open the door" do
      door.open!

      expect(device).to have_received(:call).with(:open_door)
    end
  end

  it "takes the device name from PARTICLE_DEVICE_NAME by default" do
    allow(ENV).to receive(:fetch).with("PARTICLE_DEVICE_NAME").
      and_return("my-little-particle")

    door = OpenSesame::Door.new
    expect(door.device.name).to eq "my-little-particle"
  end

end
