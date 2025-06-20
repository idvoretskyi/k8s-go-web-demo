# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Kubernetes Go web demo project that demonstrates a simple web application deployment using Go, Docker, and Kubernetes. The application uses the Gin web framework and exposes REST endpoints for health checks and basic functionality.

## Architecture

- **Go Application**: Simple web server using Gin framework with health/ready endpoints
- **Docker**: Multi-stage build for optimized container image
- **Kubernetes**: Complete deployment with Service and Ingress configuration
- **Build Automation**: Makefile with common development and deployment tasks

## Common Commands

### Development
- `make build` - Build the Go application
- `make run` - Run the application locally (listens on port 8080)
- `make test` - Run Go tests
- `make deps` - Download and tidy Go dependencies
- `make dev` - Full development workflow (deps, build, test)

### Docker
- `make docker-build` - Build Docker image
- `make docker-run` - Run containerized application locally
- `make docker-push` - Push image to registry

### Kubernetes
- `make k8s-deploy` - Deploy to Kubernetes cluster
- `make k8s-delete` - Remove deployment from cluster
- `make k8s-status` - Check deployment status
- `make k8s-logs` - View application logs
- `make deploy` - Full deployment workflow (build + deploy)

### Testing the Application
- Local: `curl http://localhost:8080/`
- Kubernetes: `curl http://k8s-go-web-demo.local/` (after ingress setup)
- Health check: `curl http://localhost:8080/health`
- Ready check: `curl http://localhost:8080/ready`

## File Structure

- `main.go` - Main application with Gin routes
- `go.mod` - Go module configuration
- `Dockerfile` - Multi-stage Docker build
- `Makefile` - Build and deployment automation
- `k8s/` - Kubernetes manifests
  - `deployment.yaml` - Application deployment with 3 replicas
  - `service.yaml` - LoadBalancer service
  - `ingress.yaml` - Ingress configuration for external access

## Requirements

- Go 1.21+
- Docker
- Kubernetes cluster with kubectl configured
- NGINX Ingress Controller (for ingress)