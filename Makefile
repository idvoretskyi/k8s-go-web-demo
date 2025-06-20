# Variables
APP_NAME=k8s-go-web-demo
DOCKER_IMAGE=$(APP_NAME):latest
KUBECTL=kubectl

# Go commands
.PHONY: build
build:
	go build -o $(APP_NAME) .

.PHONY: run
run:
	go run main.go

.PHONY: test
test:
	go test ./...

.PHONY: clean
clean:
	go clean
	rm -f $(APP_NAME)

.PHONY: deps
deps:
	go mod download
	go mod tidy

# Docker commands
.PHONY: docker-build
docker-build:
	docker build -t $(DOCKER_IMAGE) .

.PHONY: docker-run
docker-run:
	docker run -p 8080:8080 $(DOCKER_IMAGE)

.PHONY: docker-push
docker-push:
	docker push $(DOCKER_IMAGE)

# Kubernetes commands
.PHONY: k8s-deploy
k8s-deploy:
	$(KUBECTL) apply -f k8s/

.PHONY: k8s-delete
k8s-delete:
	$(KUBECTL) delete -f k8s/

.PHONY: k8s-status
k8s-status:
	$(KUBECTL) get pods,services,ingress -l app=$(APP_NAME)

.PHONY: k8s-logs
k8s-logs:
	$(KUBECTL) logs -l app=$(APP_NAME) --tail=100

# Development workflow
.PHONY: dev
dev: deps build test

.PHONY: deploy
deploy: docker-build k8s-deploy

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build        - Build the Go application"
	@echo "  run          - Run the application locally"
	@echo "  test         - Run tests"
	@echo "  clean        - Clean build artifacts"
	@echo "  deps         - Download and tidy dependencies"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container locally"
	@echo "  docker-push  - Push Docker image to registry"
	@echo "  k8s-deploy   - Deploy to Kubernetes"
	@echo "  k8s-delete   - Delete from Kubernetes"
	@echo "  k8s-status   - Show Kubernetes deployment status"
	@echo "  k8s-logs     - Show application logs"
	@echo "  dev          - Development workflow (deps, build, test)"
	@echo "  deploy       - Full deployment workflow"