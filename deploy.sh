docker build -t sarangpadalkar/multi-client:latest -t sarangpadalkar/multi-client:$SHA ./client
docker build -t sarangpadalkar/multi-server:latest -t sarangpadalkar/multi-server:$SHA ./server
docker build -t sarangpadalkar/multi-worker:latest -t sarangpadalkar/multi-worker:$SHA ./worker

docker push sarangpadalkar/multi-client:latest
docker push sarangpadalkar/multi-server:latest
docker push sarangpadalkar/multi-worker:latest

docker push sarangpadalkar/multi-client:$SHA
docker push sarangpadalkar/multi-server:$SHA
docker push sarangpadalkar/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sarangpadalkar/multi-server:$SHA
kubectl set image deployments/client-deployment client=sarangpadalkar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sarangpadalkar/multi-worker:$SHA