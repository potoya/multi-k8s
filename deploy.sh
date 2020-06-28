docker build -t peterotoya/multi-client:latest -t peterotoya/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peterotoya/multi-server -t peterotoya/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peterotoya/multi-worker -t peterotoya/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push peterotoya/multi-client:latest
docker push peterotoya/multi-server:latest
docker push peterotoya/multi-worker:latest

docker push peterotoya/multi-client:$SHA
docker push peterotoya/multi-server:$SHA
docker push peterotoya/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=peterotoya/multi-server:$SHA
kubectl set image deployments/client-deployment client=peterotoya/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peterotoya/multi-worker:$SHA
