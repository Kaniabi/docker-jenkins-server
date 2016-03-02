NAME = kaniabi/jenkins-server
VERSION = 0.1 

.PHONY: all build test latest release

all: build

run:
	#sudo docker kill jenkins-server
	sudo docker rm jenkins-server
	sudo docker run -d --publish 9090:8080 --name jenkins-server $(NAME):$(VERSION)

build:
	sudo docker build -t $(NAME):$(VERSION) .

latest:
	sudo docker tag $(NAME):$(VERSION) $(NAME):latest

release: latest
	@if ! sudo docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	sudo docker push $(NAME)
