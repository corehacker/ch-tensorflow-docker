
all:

tf_opencv:
	docker build -f Dockerfile.tf+opencv.docker -t bangaloretalkies/tf_opencv_base .
	docker push bangaloretalkies/tf_opencv_base:latest

tf_opencv_ch:
	docker build -f Dockerfile.tf+opencv+ch.docker -t bangaloretalkies/tf_opencv_ch .
	docker push bangaloretalkies/tf_opencv_ch:latest

# tf_opencv_ch
run_tf_opencv_ch:
	docker ps
	docker run -d --volume $(HOME)/workspace:/workspace \
		--name tf_opencv_ch -ti bangaloretalkies/tf_opencv_ch:latest \
		tail -f /dev/null
	docker ps

exec_tf_opencv_ch:
	docker exec -ti tf_opencv_ch bash

stop_tf_opencv_ch:
	docker ps
	docker stop tf_opencv_ch
	docker container rm tf_opencv_ch
	docker ps

