docker build -t zabhi15/multi-client:latest -t zabhi15/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zabhi15/multi-server:latest -t zabhi15/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zabhi15/multi-worker:latest -t zabhi15/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zabhi15/multi-client:latest
docker push zabhi15/multi-server:latest
docker push zabhi15/multi-worker:latest

docker push zabhi15/multi-client:$SHA
docker push zabhi15/multi-server:$SHA
docker push zabhi15/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zabhi15/multi-server:$SHA
kubectl set image deployments/client-deployment client=zabhi15/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zabhi15/multi-worker:$SHA