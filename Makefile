include deploy.conf

# Build image
build:
	docker build -t $(APP_NAME):$(VERSION) .

# Build image without cache
build-nc:
	docker build --no-cache -t $(APP_NAME):$(VERSION) .

# Run image
run:
	docker run --rm -it --name="$(APP_NAME)" $(APP_NAME):$(VERSION)

bash:
	docker run --rm -it --name="$(APP_NAME)" $(APP_NAME):$(VERSION) bash

up: build run

stop:
	docker stop $(APP_NAME) && \
	docker rm $(APP_NAME)

