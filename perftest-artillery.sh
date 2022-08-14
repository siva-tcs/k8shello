projectid=$(gcloud config get-value project)
namespace=apps
gkecluster=myk8s
zone=$(gcloud config get-value compute/zone)
gcloud services enable container.googleapis.com
echo "getting credentials"
gcloud container clusters  get-credentials $gkecluster --zone $zone --project $projectid
kubectl get all -n apps
echo "Performance testing web apis"
#npm install -g artillery@latest
artillery run --output report.json config-artillery.yaml 

