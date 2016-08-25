NAME = kaniabi/jenkins-server
VERSION = 0.4.0

.PHONY: all build test latest release

all: build

run:
	#sudo docker kill jenkins-server
	sudo docker rm jenkins-server
	sudo docker run -d --publish 9090:8080 --name jenkins-server $(NAME):latest

build:
	sudo docker build -t $(NAME):latest -t $(NAME):$(VERSION) .
