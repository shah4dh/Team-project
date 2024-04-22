## Project Scenario

The Northcoders development teams have worked on creating a learner management system

![](nclearner.png)

The development teams have been structured by the organisation such that one team has produced the frontend and a separate team have produced the backend.

The backend application is configured to talk to a relational database. Currently the backend team have been using an in-memory relational database when testing.

### Frontend

#### Technologies
- Vite
- React
- HTML
- CSS

#### Repository

https://github.com/northcoders/ce-team-project-frontend

### Backend

#### Technologies
- Java
- Maven
- Spring Boot
- Spring Actuator
- Spring JDBC for database access

#### Repository

https://github.com/northcoders/ce-team-project-backend

### Objective

Our primary objective, as a team, is to get the applications and supporting services deployed to AWS cloud.

#### The steps our team is taking are as follows:

- Creating an Infrastructure comprising of a VPC, 3 private and public subnets, an internet gateway a NAT gateway and its different security groups.

- Building and applying the backend and frontend images and deploying them in their various containers using ECRs.

- Using Jenkins CI/CD to continuously deploy and integrate the services onto our cluster.

- Making use of prometheus and grafana to monitor our cluster and its constituent services.

- Add an SES in case our tresholds are exceeded.

## Installing the Helm Charts

First, from the `helm` directory install the backend server. Next update the frontend `values.yaml` file with the DNS of the backend service. Then install the frontend.

### Install the Backend Server

To install the chart with the release name `backend` from within the `helm` directory use:

```bash
helm install backend ./backend
```

> Note: the chart can be installed with any release name just replace `backend` with your preferred name.

Next take a note of the `EXTERNAL-IP` of the `be-service` in order to configure the frontend:

```bash
kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP                 PORT(S)        AGE
be-service   LoadBalancer   172.20.30.224   ad422xxx.amazonaws.com      80:30125/TCP   70m
```

> Note: in this example the `EXTERNAL-IP` `ad422aa3fd4e643b4af04018dd421b7e-6446255.eu-west-2.elb.amazonaws.com` has been abbreviated to `ad422xxx.amazonaws.com`

### Install the Frontend Server

Before installing the frontend update the `baseApi` value in the `values.yaml` with the DNS from the previous step. For example:

```yaml
baseApi: ad422aa3fd4e643b4af04018dd421b7e-6446255.eu-west-2.elb.amazonaws.com
```

Next install the chart with the release name `frontend` from the within helm directory:

```bash
helm install frontend ./frontend
```

> Note: again the chart can be installed with any release name, just replace `frontend`.

Next take a note of the `EXTERNAL-IP` of the `fe-service` and use this in the Web Browser to access the frontend.

```bash
kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP              PORT(S)        AGE
fe-service   LoadBalancer   172.20.214.61   ade14xxx.amazonaws.com   80:30231/TCP   27m
```

> Note: in this example `EXTERNAL-IP` `ade14ac02cd1149119f3683676b4cc79-1691019730.eu-west-2.elb.amazonaws.com` is abbreviated.

The use `http://ade14ac02cd1149119f3683676b4cc79-1691019730.eu-west-2.elb.amazonaws.com` to access the frontend app.

## Installing Jenkins 

To install Jenkins through kubernetes, follow these simple steps. First head over to the `jenkins` directory and before anything, change the node value inside the `volume.yaml` file.

Next you need to create a namespace callend `devops-tools`

```bash
kubectl create namespace devops-tools
```

Then you need to apply the `serivceAccount.yaml` file.

```bash
kubectl apply -f serviceAccount.yaml
```

Then you need to create the `volume.yaml` file.

```bash
kubectl create -f volume.yaml
```

Then you need to apply the `deployment.yaml` file.

```bash
kubectl apply -f deployment.yaml
```

Finally, apply the `service.yaml` file.

```bash
kubectl apply -f service.yaml 
```

Now when you have a look at your services, there will be a jenkins-service that is type LoadBalancer with a public dns to access Jenkins on port 8080. For example:

`http://af333cb778e604b3f9730ea4ce1e7814-350983585.eu-west-2.elb.amazonaws.com:8080` will give me acccess to jenkins.

> Note: To have a look at your jenkins-service run `kubectl get services -n devops-tools`

### To log the Password

After accessing Jenkins you will be prompted with the sign in page. The username will be admin and to get the password, follow these steps.

First display the pods to find out what your jenkins deployment is called. 

```bash
kubectl get pods -n devops-tools
```

Then you can run this command and it will give you your password and should now be able to log in to Jenkins.

```bash
kubectl exec -it jenkins-56b6774bb6-8m5t2 cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools
```

> Note: You will have to change `jenkins-56b6774bb6-8m5t2` to whatever your deployment is called

You should now successfully have access to get into Jenkins!