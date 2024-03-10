redis_ns_check=$(kubectl get ns redis-cls | grep redis-cls | awk '{print $1}')
redis_helm_status=$(helm list --filter my-redis -n redis-cls | grep my-redis | awk '{print $1}')

if [ -z $redis_ns_check ]
then
  echo "redis namespace is not there, Lets create a new namespace and install Redis cluster there !"
  kubectl create ns redis-cls
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  helm install my-redis bitnami/redis -n redis-cls
elif [-n $redis_ns_check && -z $redis_helm_status ]
then 
  echo "redis namespace is there, but redis cluster need to install !"
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  helm install my-redis bitnami/redis -n redis-cls
else
  echo "namespace and cluster already present in redis namespace, only need to upgrade existing one"
  helm upgrade my-redis bitnami/redis -n redis-cls
fi
