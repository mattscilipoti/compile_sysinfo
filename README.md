# Compiles executables of sysinfo, using docker

Provides executables of the [sysinfo](https://github.com/zcalusic/sysinfo) package, on the host computer, using a docker container to isolate dependencies.

[Sysinfo](https://github.com/zcalusic/sysinfo) is a Go library providing Linux OS / kernel / hardware system information (as json).

> No dependencies are installed on the host computer (except for docker).

## To compile executables (for linux 386/amd64) in `./bin/`

### tl;dr

```
docker-compose up
```

Use the executables in `./bin/`

### Complete Instructions

1. Install [docker](https://docs.docker.com/get-docker/) (once you see this, you will want docker for other projects)
1. Clone this repo from https://github.com/mattscilipoti/compile_sysinfo
1. Go to the repo: `cd compile_sysinfo`
1. Run: `docker-compose up`
1. The executables are in the `./bin` dir on your computer
1. Run one on a linux system to see a json payload of System Information.

> You just compiled go executables without installing anything (except for docker).

## Environment Variables

- GO_OUTPUT_DIR: specifies the directory, in the container, where the executables are generated. The container side of the shared volume.
  - default: `/app/bin`
- GOARCHs: space-delimited list of architectures (one executable per).
  - default: `386 amd64`
- GOOS: configures the executables target OS
  - default: `linux` (the only supported OS)
- HOST_OUTPUT_DIR: specifies the directory, on the host, to receive the executables. Used as a shared volume.
  - default: `./bin`

## Explanation

The docker image contains all the dependencies needed to run make and compile go. We use docker-compose to setup a shared volume and run `make sysinfo` within the container. This generates the executables in the host computer's `./bin` dir. 
> **!** Each run overwrites existing files in `./bin`

The environment variables, in the `.env` file, indicate the executable's architecture and specify the output dir on both the host and container. This provides a single-point-of-truth for info used in the `docker-compose.yml` and `Makefile`. 

All files in `docker_support/` are copied into the WORKDIR of the image (and called within the image).

- How do the executable files, compiled within the docker container, get to the host computer? 
  - Answer: The file is actually compiled directly into the host computer's `bin/` dir by directing the output to a shared volume (defined in `docker-compose.yml`).
- Why use the `.env` file, instead of naming directly in `docker-compose.yml`?
  - In order to reference the environment variables in teh `docker-compose.yml` file, for the volume data, they needed to be passed at the command line or put in the `.env` file.
- Do I need use `docker-compose.yml`?
  - Nope. You could call `docker run`, passing the appropriate values for the shared volume, environment variables, and execute `make sysinfo` inside the container. We felt `docker-compose up` was easier to get right, every time.

### License
This code is released under the MIT License.