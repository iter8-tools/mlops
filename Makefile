# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

# Build the docker image
docker-build:
		$(call check_defined, IMG)
		$(call check_defined, MODEL_NAME)
		$(call check_defined, LOCAL_MODEL_DIR)
		$(call check_defined, MODEL_VERSION)
		DOCKER_BUILDKIT=1 docker build -t $(IMG) --no-cache --build-arg MODEL_NAME=$(MODEL_NAME) --build-arg LOCAL_MODEL_DIR=$(LOCAL_MODEL_DIR)/$(MODEL_VERSION)/. --build-arg MODEL_VERSION=$(MODEL_VERSION) .

# Run the docker image locally
docker-run:
		$(call check_defined, IMG)
		docker run -d --rm -p 8501:8501 $(IMG)

# Push the docker image
docker-push:
		$(call check_defined, IMG)
		docker push $(IMG)