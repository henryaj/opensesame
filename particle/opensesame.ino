// opensesame source for use with Spark/Particle
// particle.io

int openDoor(String command);

void setup() {
    // expose openDoor function to Particle API
    Particle.function("openDoor", openDoor);
}

void loop() {}

// open door; return 1 on success
int openDoor(String command) {
    return 1;
}
