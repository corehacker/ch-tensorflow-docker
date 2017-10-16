


all: default

new: indexer-new

default: indexer

indexer: base
	docker build -t bangaloretalkies/tensorflow-ch-indexer .
	docker push bangaloretalkies/tensorflow-ch-indexer:latest

indexer-new:
	docker build --no-cache -t bangaloretalkies/tensorflow-ch-indexer .
	docker push bangaloretalkies/tensorflow-ch-indexer:latest

base:
	docker build -f Dockerfile.base -t bangaloretalkies/tensorflow-ch-base .
	docker push bangaloretalkies/tensorflow-ch-base:latest

base-new:
	docker build --co-cache -f Dockerfile.base -t bangaloretalkies/tensorflow-ch-base .
	docker push bangaloretalkies/tensorflow-ch-base:latest
