VERSION ?= 0.6

build:
	docker buildx build --platform linux/amd64 -t producao:${VERSION} .

tag:
	docker tag producao:${VERSION} gcr.io/fiap-tech-challenge-403000/producao-service-tech-challenge:${VERSION}

push:
	docker push gcr.io/fiap-tech-challenge-403000/producao-service-tech-challenge:${VERSION}

all: build tag push