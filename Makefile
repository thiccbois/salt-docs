.PHONY: all set-base build base login aws-login push run mkdocs
#
# make build-base login push - will build and push the base image
# make build login push - will build and push the app image
#
TAG:=$$(git log -1 --pretty=%h)
NAME:=rosscdh/salt-docs
VERSION:=${NAME}:${TAG}
LATEST:=${NAME}:latest

BUILD_REPO_ORIGIN=$$(git config --get remote.origin.url)
BUILD_COMMIT_SHA1:=$$(git rev-parse --short HEAD)
BUILD_COMMIT_DATE:=$$(git log -1 --date=short --pretty=format:%ct)
BUILD_BRANCH:=$$(git symbolic-ref --short HEAD)
BUILD_DATE:=$$(date -u +"%Y-%m-%dT%H:%M:%SZ")

DOCKERFILE=Dockerfile
REGISTRY=registry.hub.docker.com
AWS_REGION:=eu-central-1

all: build login push

mkdocs:
	pushd salt-docs;mkdocs build;popd

build:
	docker build -t ${LATEST} -t ${VERSION} -t ${REGISTRY}/${LATEST} -t ${REGISTRY}/${VERSION} \
				 --build-arg BUILD_COMMIT_SHA1=${BUILD_COMMIT_SHA1} \
				 --build-arg BUILD_COMMIT_DATE=${BUILD_COMMIT_DATE} \
				 --build-arg BUILD_BRANCH=${BUILD_BRANCH} \
				 --build-arg BUILD_DATE=${BUILD_DATE} \
				 --build-arg BUILD_REPO_ORIGIN=${BUILD_REPO_ORIGIN} \
				 . --file ./${DOCKERFILE}

login:
	docker login ${REGISTRY}

aws-login:
	eval `aws ecr get-login --no-include-email --region ${AWS_REGION}`

push:
	docker push ${REGISTRY}/${LATEST}
	docker push ${REGISTRY}/${VERSION}

run:
	docker run --rm -p 8080:8043 -v ${PWD}/salt-docs/site:/srv/http --name salt-docs ${LATEST}