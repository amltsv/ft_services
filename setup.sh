
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb.yaml

names="nginx influxdb grafana mysql phpmyadmin wordpress ftps "

for name in $names
do
	echo
	echo "Now build $name"
	docker build -t my-image-$name srcs/$name/ > /dev/null
	echo "Build $name completed"
done
echo
for name in $names
do
	kubectl apply -f srcs/$name/$name.yaml
done

minikube dashboard