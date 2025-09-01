REGISTRY ?= abeyuki
IMAGE    ?= minecraft-bedrock-arm64
TAG      ?= $(shell git rev-parse --short HEAD)
PLAT     ?= linux/arm64
CTX      ?= .

.PHONY: login init-builder build-local build-test build-push release

login:
	@echo "$(TOKEN)" | docker login -u "abeyuki" --password-stdin

init-builder:
	@docker buildx ls | grep -q ' bk ' || docker buildx create --name bk --driver docker-container --use
	@docker buildx inspect --bootstrap


build-local:
	docker buildx build \
	  --platform $(PLAT) \
	  -t $(REGISTRY)/$(IMAGE):$(TAG) \
	  -f Dockerfile $(CTX) \
	  --load

build-test:
	docker buildx build \
	  --platform $(PLAT) \
	  -t $(REGISTRY)/$(IMAGE):$(TAG) \
	  -f Dockerfile $(CTX)

build-push: 
	docker buildx build \
	  --platform $(PLAT) \
	  -t $(REGISTRY)/$(IMAGE):$(TAG) \
	  -f Dockerfile $(CTX) --push

release: build-test build-push
