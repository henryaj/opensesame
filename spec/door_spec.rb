require "door"

describe OpenSesame::Door do
  let(:particle) { class_double(Particle, device: device) }
  let(:device) { instance_double(Particle::Device,
    call: nil, name: "my-little-particle")
  }
  let(:logger) { instance_double(Logger, error: true) }

  before do
    allow(Logger).to receive(:new).and_return(logger)
  end

  describe "#open" do
    let(:door) { OpenSesame::Door.new(device: device)}

    it "instructs the Particle to open the door" do
      door.open!

      expect(device).to have_received(:call).with(:open_door)
    end

    context "when there is an error" do
      it "deals nicely with errors" do
        allow(device).to receive(:call).with(:open_door).
          and_raise Exception

        result = door.open!

        expect(logger).to have_received(:error)
        expect(result).to eq("error")
      end
    end

  end

  it "takes the device name from PARTICLE_DEVICE_NAME by default" do
    expect(ENV).to receive(:fetch).with("PARTICLE_DEVICE_NAME").
      and_return("my-little-particle")
    expect(Particle).to receive(:device).with("my-little-particle").
      and_return(device)

    door = OpenSesame::Door.new
    expect(door.device.name).to eq "my-little-particle"
  end

end
