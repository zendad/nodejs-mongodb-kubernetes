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
This code has been tested on the following versions of kubernetes, I cannot guarantee it will work on any other version, without modifications.
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

run command
```
    kubectl apply -f mongodb.yml
```
### Deploying NodeApp

run command
```
    kubectl apply -f mongodb.yml
```

# Running the app
Access the app through the nodeport or ingress on your browser. To add user users to the database, register a user. Login in with the created user. if the user was successfully added to the database and the credetials are correct, when you login the following message shoud appear on the browser
```
Congratulations, Your login is successful
```

