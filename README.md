The steps our team is taking are as follows:

-Creating an Infrastructure comprising of a vpc and 3 private and public subnets, an internet gateway a nat gateway and its different security groups.

-Building and applying the backend and front end images and deploying them in their various containers using ECRs.

-Use Jenkins CI/CD to continuously deploy and integrate the services onto our cluster.

-Making use of prometheus to monitor our cluster and its constituent services.

-Add an SES in case our tresholds are exceeded.

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
