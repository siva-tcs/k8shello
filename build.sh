#Change project id and namespace here
projectid=notional-portal-349616
namespace=apps
gkecluster=myk8s
#gcloud container clusters create myk8s --project notional-portal-349616 --zone europe-west2-a --num-nodes=2
#replacing wth project id
sed -i 's/projectid/{$projectid}/g' deployment.yaml
echo "Cloning Spring boat application"
#git clone https://github.com/spring-projects/spring-petclinic
sleep 5
echo "Builiding application with docker"
docker build --tag  gcr.io/$projectid/hello .
sleep 5
docker push gcr.io/$projectid/hello
# switching to training cluster
gcloud container clusters  get-credentials $gkecluster
sleep 5
kubectl apply -f deployment.yaml -n $namespace
sleep 5
kubectl apply -f service.yaml -n $namespace
sleep 5

