# Running Nodejs App with Mongodb in Kubernetes
The app is developed in nodejs with a mongodb database. App requires [Node.js](https://nodejs.org/) v10+ to run. it is deployed in Docker.

# Enviroment virables
The following enviroment variables are set for the app, please check the Dockerfile on the defaults.

App
```
SERVER_PORT=8080
ENV DB_HOST='localhost'
ENV DB_PORT=27017
ENV DB_NAME='nodeapp'
```
mongodb
```
MONGODB_ROOT_PASSWORD
MONGODB_SYSTEM_LOG_VERBOSITY
MONGODB_DISABLE_SYSTEM_LOG
MONGODB_ENABLE_IPV6
MONGODB_ENABLE_DIRECTORY_PER_DB
```

# Kubernetes Version Compatibility
This app has been tested on the following versions of kubernetes, I cannot guarantee it will work on any other version, without modifications.
```
    Kubernetes 1.14	
    Kubernetes 1.15
```

# Requirements
The app is developed in nodejs with a mongodb database, for running the app in kuberneetes the followin are required
1. kubectl v15.5.5+
2. kubernetes cluster v1.14+
3. Preinstalled mongodb  - this will be installed in the kubernetes cluster


# Deploying on Kubernetes
Defaults variables are defined in the Docker image. These can be changed to customize the app deployment. Check the nodeapp.yml or mongodb.yml to change the variables. To access the app either deploy an ingress or use nodeport as defined in the manifests 


   
 ### Deploying mongodb
Note - Mongodb is not using a persistent volume, should it restart, all data will be lost, You can enable the use of persistent volume, check details [here](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

run command
```
    kubectl apply -f kubernetes/mongodb.yml
```

expected output

```
serviceaccount/mongodb created
secret/mongodb created
service/mongodb created
deployment.apps/mongodb created
```
### Deploying NodeApp

run command
```
    kubectl apply -f  kubernetes/mongodb.yml
```

expected output
```
service/node-http created
service/node-app-nodeport created
deployment.apps/node-app created
ingress.extensions/node-app created
```


K8 services
```
kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/mongodb-57495cf44c-9kxqg    1/1     Running   0          6m40s
pod/node-app-7b787fcd56-x4cn6   1/1     Running   0          6m5s

NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes          ClusterIP   10.96.0.1        <none>        443/TCP          9m41s
service/mongodb             ClusterIP   10.96.156.39     <none>        27017/TCP        6m40s
service/node-app-nodeport   NodePort    10.108.254.120   <none>        8080:31000/TCP   6m5s
service/node-http           ClusterIP   10.103.66.100    <none>        8080/TCP         6m5s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mongodb    1/1     1            1           6m40s
deployment.apps/node-app   1/1     1            1           6m5s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/mongodb-57495cf44c    1         1         1       6m40s
replicaset.apps/node-app-7b787fcd56   1         1         1       6m5s


```

# Running the app
Access the app through the nodeport or ingress on your browser. 

1. To add users to the app, register a user. Login in with the created user. , you can also check the logs for the app to iff is the user was created succefully or check  the database.

This message should show
```
User Registered, Please Login
```
2. if the user was successfully added to the database and the credetials are correct, when you login the following message shoud appear on the browser
```
Congratulations, Your login is successful
```

