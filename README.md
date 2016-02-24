# OpenSesame [![Build Status](https://travis-ci.org/henryaj/opensesame.svg?branch=master)](https://travis-ci.org/henryaj/opensesame)

Sometimes, doors should open themselves.

(I wanted a way to open my front gate remotely, so I built this.)

## Requirements

* server able to run this code
* [Particle](http://particle.io) device or similar (Spark Core, Photon, Electron)

## Setup

* Ensure that your `PARTICLE_DEVICE_NAME`, `PARTICLE_ACCESS_TOKEN` and `SECRET_CODE` are set. Then `rackup`.
* Get a [Twilio](http://twilio.com) number, and ensure that incoming SMS messages POST to `<your-server-address>/open`.
* Send a text to your number containing only your `SECRET_CODE`.
* Marvel as your door opens.
