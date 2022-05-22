projectid=<yourprojectid>
namespace=apps
gkecluster=myk8s
zone=europe-west2-a

echo "Creating cluster"
gcloud container clusters create $gkecluster --project $projectid --zone $zone --num-nodes=2
echo "getting credentials"
gcloud container clusters  get-credentials $gkecluster --zone $zone --project $projectid
docker build --tag  gcr.io/$projectid/hello .
docker push gcr.io/$projectid/hello
kubectl create ns apps

kubectl apply -f deployment.yaml -n $namespace
kubectl apply -f service.yaml -n $namespace


kubectl get all -n apps

