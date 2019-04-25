IMAGE = reinvent/cuda9.1
TAG = 0.1

build:
	nvidia-docker build -t $(IMAGE):$(TAG) .

run:
	nvidia-docker run -ti -v $$PWD:/supp -p 5006:5006 $(IMAGE):$(TAG)

clean:
	@running="$$(docker ps -aq)" ; \
	if [ -n "$$running" ] ; then \
	    echo Removing instances $$running ; \
		docker rm $$running ; \
	fi ; \
	nones="$$(docker images | grep none | awk '{print $$3}')" ; \
	if [ -n "$$nones" ] ; then \
		echo Removing images $$nones ; \
		docker rmi $$nones ; \
	fi ;
