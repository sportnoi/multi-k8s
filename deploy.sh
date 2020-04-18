docker build -t sportnoi/multi-client:latest -t sportnoi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sportnoi/multi-server:latest -t sportnoi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sportnoi/multi-worker:latest -t sportnoi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sportnoi/multi-client:latest
docker push sportnoi/multi-server:latest
docker push sportnoi/multi-worker:latest

docker push sportnoi/multi-client:$SHA
docker push sportnoi/multi-server:$SHA
docker push sportnoi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sportnoi/multi-server:$SHA
kubectl set image deployments/client-deployment client=sportnoi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sportnoi/multi-worker:$SHA