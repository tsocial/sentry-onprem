REPOSITORY?=tsocial/sentry
TAG?=9.1.1

OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

docker_login:
	echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USERNAME)" --password-stdin

build: docker_login
	@echo "$(OK_COLOR)==>$(NO_COLOR) Building $(REPOSITORY):$(TAG)"
	@docker build --pull --rm -t $(REPOSITORY):$(TAG) .

$(REPOSITORY)_$(TAG).tar: build
	@echo "$(OK_COLOR)==>$(NO_COLOR) Saving $(REPOSITORY):$(TAG) > $@"
	@docker save $(REPOSITORY):$(TAG) > $@

push: build
	@echo "$(OK_COLOR)==>$(NO_COLOR) Pushing $(REPOSITORY):$(TAG)"
	@docker push $(REPOSITORY):$(TAG)

.PHONY: all build push
