REPO=spetix
VERSION := $(shell git rev-parse HEAD)



build: 
	podman build -t $(REPO)/godevcontainer:${VERSION} .