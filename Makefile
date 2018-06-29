# build server container
build:
	GOOS=linux go build -o server
	@eval $$(minikube docker-env) ;\
	docker build -t test-app:v1 .

# create kubernetes cluster & service

create:
	kubectl create -f deploy/k8s.yaml

# delete kubenetes cluster & service
delete:
	kubectl delete -f deploy/k8s.yaml

# clean working directory
clean:
	rm -f server

# create heapster, graphana & influxdb 
# monitoring service
heapster-up:
	kubectl create -f heapster/

# delete heapster cluster
heapster-down:
	kubectl delete -f heapster/

# show test app
show:
	minikube service test-svc

# app logs
logs:
	kubectl logs -l app=my-app

# list minikube services for urls
list-svc:
	minikube service list

TEST_SERVICE_URL:=$(shell minikube service test-svc --url)/test
# 2 requests per second
test:
	while true; do curl $(TEST_SERVICE_URL) && sleep 0.5 && echo "" ; done

testx:
	# +/- 100 request / second
	while true; do curl $(TEST_SERVICE_URL) && sleep 0.01 && echo "" ; done

# +/- 10 000 request / second
testxx:
	while true; do curl $(TEST_SERVICE_URL) && sleep 0.00001 && echo "" ; done