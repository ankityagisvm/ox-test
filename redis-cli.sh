rediscli_ns_check=$(kubectl get ns redis-cli | grep redis-cli | awk '{print $1}')
rediscli_helm_status=$(helm list --filter redis-cli -n redis-cli | grep redis-cli | awk '{print $1}')

if [ -z $rediscli_ns_check ]
then
  echo "rediclis namespace is not there, Lets create a new namespace and install RedisCli cluster there !"
  kubectl create ns redis-cli
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  helm install my-redis bitnami/redis -n redis-cli
elif [-n $rediscli_ns_check && -z $rediscli_helm_status ]
then 
  echo "redis namespace is there, but redis cluster need to install !"
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  helm install my-redis bitnami/redis -n redis-cli
else
  echo "namespace and cluster already present in redis namespace, only need to upgrade existing one"
  helm upgrade my-redis bitnami/redis -n redis-cli
fi
