include deploy.conf

# Build image
build:
	docker build --build-arg HADOOP_VERSION=$(HADOOP_VERSION) -t $(APP_NAME):$(VERSION) .

# Build image without cache
build-nc:
	docker build --no-cache --build-arg HADOOP_VERSION=$(HADOOP_VERSION) -t $(APP_NAME):$(VERSION) .

# Run image
run:
	docker run --rm -it --name="$(APP_NAME)" $(APP_NAME):$(VERSION)

# Run image with bash prompt
bash:
	docker run --rm -it --name="$(APP_NAME)" $(APP_NAME):$(VERSION) bash

# Build and run image
up: build run

# Stop running container
stop:
	docker stop $(APP_NAME) && \
	docker rm $(APP_NAME)

