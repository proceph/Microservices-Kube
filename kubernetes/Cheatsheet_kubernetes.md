# Create deployment with manifest

## Create deployment from manifest
### Create a manifest from an existing image
kubectl create deployment nginx --image=nginx -o yaml --dry-run  

### Execute manifest
kubectl apply -f my_manifest.yml  

## Manifest basics 
### The 5 parts of the manifest file
api : the api used by kubernetes master, may vary depending on kind  
kind : the kind of ressource (Deployment, Service, Pod, etc.)  
medatata : name and label  
spec : configuration of the object, the most interesting part  
status : only visible after executing the script and with a specific command, give the state, number of replicas and current version  

### Ressources
service : communicate between services and the internet  
deployment : deploy one image. A number of replica can be selected  
HorizontalPodAutoscaler : autoscale pods horizontaly  


# Create Horizontal Pod Autoscaler (HPA)
## Prerequisite : metrics server
[Install metrics server if it is not installed](kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml)
Check if it is installed with : `kubectl get ServiceAccount metrics-server` (not sure of this one, should be tested)

## Generate the hpa through manifest
In the same yml file that contains your deployment and service, adds the following lines and modifies it according to your config : 
```
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: give-a-name-to-your-hpa # to replace with the name you want to give
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: name-of-your-deployment # to replace with the name of your deployment 
  minReplicas: 1
  maxReplicas: 6
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50

```
*Note : in case of a databse cpu usage should be changed for memory usage. [See more here](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics)*
 
Apply your manifest with : `kubectl apply -f manifest-name.yml`

## Test the scaling
Opening another terminal and take inspiration from the following command to send regular package to your service in order to increase CPU usage : 
`kubectl run -i --tty ping-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"``  
  
Take a look at you hpa : `kubectl get hpa name-of-your-hpa --watch`. The percentage of cpu and the number of pods should go up.


# Create deployment without manifest
### Create deployment
kubectl create deployment nginx --image=my\_custom\_nginx\_image  

If previous steps isn't enough, this line create a deployment from a local image :  
kubectl patch deployment nginx -p '{"spec":{"template":{"spec":{"containers":[{"name":"<container-name>","imagePullPolicy":"never"}]}}}}'

### Scale deployment
kubectl scale deployments/nginx --replicas=3  

### Open terminal in pod
kubectl proxy &
export POD_NAME="$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')"  
kubectl exec -ti $POD_NAME -- bash  

### Create services
kubectl expose deployment/nginx --type="NodePort" --port 8080  
`type` specifies the type of service  

# Use kubernetes playground to test kubernetes deployment
## Kubernetes playground
Go to [https://labs.play-with-k8s.com](https://labs.play-with-k8s.com) and indentify with your github or docker account. 
## Install minikube
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
```
## Launch minikube
`minikube start --force`
You can now deploy your application.



