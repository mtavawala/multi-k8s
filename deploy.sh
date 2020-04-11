docker build -t mustafat/multi-client:latest -t mustafat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mustafat/multi-server:latest -t mustafat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mustafat/multi-worker:latest -t mustafat/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mustafat/multi-client:latest
docker push mustafat/multi-server:latest
docker push mustafat/multi-worker:latest

docker push mustafat/multi-client:$SHA
docker push mustafat/multi-server:$SHA
docker push mustafat/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mustafat/multi-server:$SHA
kubectl set image deployments/client-deployment server=mustafat/multi-client:$SHA
kubectl set image deployments/worker-deployment server=mustafat/multi-worker:$SHA
