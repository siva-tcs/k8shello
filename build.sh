projectid=$(gcloud config get-value project)
namespace=apps
gkecluster=myk8s
zone=$(gcloud config get-value compute/zone)
gcloud services enable container.googleapis.com
echo "Creating cluster"
#gcloud container clusters create $gkecluster --project $projectid --zone $zone --num-nodes=1
echo "getting credentials"
gcloud container clusters  get-credentials $gkecluster --zone $zone --project $projectid
#docker build --tag  gcr.io/$projectid/hello .
#docker push gcr.io/$projectid/hello
#kubectl create ns apps
echo "replace {projectid} with "$projectid
sed -i "s/{projectid}/$projectid/" deployment.yaml
cat deployment.yaml
kubectl apply -f deployment.yaml -n $namespace
kubectl apply -f service.yaml -n $namespace

kubectl get all -n apps
