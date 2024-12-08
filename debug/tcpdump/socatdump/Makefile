CONTAINERNAME=socatdump
VERSION=v0.0.1
IMAGENAME=$(USER)/$(CONTAINERNAME)
LOCALREGISTRYNAME=localhost:5001/$(CONTAINERNAME)

BUILDFLAG=$(CONTAINERNAME)_$(VERSION)

$(BUILDFLAG): Makefile Dockerfile entrypoint.sh
	docker build -t $(IMAGENAME):$(VERSION) .
	touch $(BUILDFLAG)

clean:
	docker image rm  $(IMAGENAME):$(VERSION)
	rm -f $(BUILDFLAG) capture.pcap

start:
	docker run -d --name $(CONTAINERNAME) --rm -it -p 8888:8888 $(IMAGENAME):$(VERSION) 8888 httpbin.org:80

stop:
	docker stop $(CONTAINERNAME)

shell:
	docker exec -it $(CONTAINERNAME) /bin/bash

capture:
	docker exec -it $(CONTAINERNAME) /usr/bin/tcpdump -i eth0 -n -w /capture.pcap

cp:
	docker cp $(CONTAINERNAME):/capture.pcap capture.pcap

push:
	docker tag $(IMAGENAME):$(VERSION) $(LOCALREGISTRYNAME):$(VERSION)
	docker push $(LOCALREGISTRYNAME):$(VERSION)
	docker rmi $(LOCALREGISTRYNAME):$(VERSION)
