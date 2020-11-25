# Used withing the container to compile executables
# These enviroment variables are used to sync the expectations
#   between the image, `docker-compose.yml` and this `Makefile`
SHELL = /bin/sh
announce:
	@echo "Executables are in ${HOST_OUTPUT_DIR}:"
	@ls ${GO_OUTPUT_DIR}

# main job to compile sysinfo executable
sysinfo: compile announce

# calls the job for each architecture
compile: ${GOARCHs}

# creates a "job" named after each architecture in GOARCHs
$(GOARCHs):
	go build -o ${GO_OUTPUT_DIR}/sysinfo-${GOOS}-$@ main.go
