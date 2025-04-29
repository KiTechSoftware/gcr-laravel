.PHONY: build manifest-push push clean

# Core variables
IMAGE=ghcr.io/kitechsoftware/laravel
DOCKERFILE_DIR=.

# Architectures separately (for manifests)
ARCHS=amd64 arm64

# Build image for all platforms
build:
	@for arch in $(ARCHS); do \
		echo "🏗 Building final for $$arch..."; \
		podman build --pull --rm \
			--arch=$$arch \
			--file $(DOCKERFILE_DIR)/debian/Dockerfile \
			--tag $(IMAGE):$$arch \
			--format docker \
			$(DOCKERFILE_DIR)/debian; \
	done

# Create and push multi-arch manifest
manifest-push:
	@echo "📦 Creating manifest for Laravel..."
	podman push $(IMAGE):amd64
	podman push $(IMAGE):arm64

	podman manifest rm $(IMAGE):latest || true
	podman rmi $(IMAGE):latest || true
	podman manifest create $(IMAGE):latest
	@for arch in $(ARCHS); do \
		podman manifest add $(IMAGE):latest docker://$(IMAGE):$$arch; \
	done
	podman manifest push $(IMAGE):latest docker://$(IMAGE):latest


# Build and push
push: build manifest-push

# Clean images
clean:
	@echo "🧹 Cleaning images for Laravel..."
	for arch in $(ARCHS); do \
		podman rmi $(IMAGE):$$arch || true; \
	done
	podman rmi $(IMAGE):latest || true
