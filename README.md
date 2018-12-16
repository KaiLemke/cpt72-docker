# cpt72-docker
Cisco Packet Tracer 7.2 via Docker inspired by somatorio/docker-packet-tracer

## Disclaimer

You need to have an active account at https://netacad.com.

## Building

1. Clone this repository.
1. Change the user and group settings to your need by editing the Dockerfile.
1. cd to this repository.
1. Download the Linux Desktop Version 7.2 from netacad and save it as *pt.tar.gz*.
1. `docker build .`

## 1st Usage

```
mkdir ~/.cpt72
mkdir ~/.cptFirefox

xhost +local:

docker run -it \
  -v /tmp/.X11-unix/:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  -v ~/.cpt72:/home/pt/pt \
  -v ~/.cptFirefox:/home/pt/.mozilla/firefox \
  -e DISPLAY=unix$DISPLAY \
  CONTAINER_NAME
```
