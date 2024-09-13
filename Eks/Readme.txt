Deploying an application in Amazon EKS (Elastic Kubernetes Service) using ConfigMaps and NGINX Ingress involves several steps.
### 1. Set Up EKS Cluster

Assuming you already have an EKS cluster set up, if not, follow [AWS EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html) to create one.

### 2. Configure `kubectl` for EKS

Ensure your `kubectl` is configured to communicate with your EKS cluster:


aws eks --region <region> update-kubeconfig --name <cluster-name>
```

Replace `<region>` with your AWS region and `<cluster-name>` with the name of your EKS cluster.

### 3. Install Helm (if not already installed)

You can install Helm using the Snap package manager:

sudo snap install helm --classic
```

### 4. Add the NGINX Ingress Controller Helm Repository

Add the NGINX Ingress Helm repository and update it:

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx/
helm repo update
```

### 5. Create a Namespace for Ingress

Create a namespace for the Ingress Controller:

kubectl create namespace ingress-nginx
```

### 6. Install the NGINX Ingress Controller

Install the NGINX Ingress Controller using Helm:

```sh
helm install my-ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx
```

### 7. Create an Application Deployment

Create a YAML file for your application deployment and service. Save it as `app-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app
        image: nginx:alpine
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
  namespace: default
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```

Apply the deployment and service:

```sh
kubectl apply -f app-deployment.yaml
```

### 8. Create an Ingress Resource

Create an Ingress resource YAML file. Save it as `app-ingress.yaml`:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: <your-custom-domain>
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app-service
            port:
              number: 80
```

Replace `<your-custom-domain>` with your custom domain name.

Apply the Ingress resource:

kubectl apply -f app-ingress.yaml
```

### 9. Set Up a Custom Domain with AWS Route 53

1. **Create a Hosted Zone:**
   - Go to the Route 53 console.
   - Create a new hosted zone with your custom domain.

2. **Update DNS Records:**
   - Get the external IP address of the NGINX Ingress Controller service:

     
     kubectl get services --namespace ingress-nginx
     ```

     Look for the `EXTERNAL-IP` of the `ingress-nginx-controller` service.

   - Add an A record in your Route 53 hosted zone to point to the `EXTERNAL-IP`.

### 10. Verify Your Setup

1. **Check the Ingress:**

   Ensure that the Ingress is set up correctly:

   
   kubectl get ingress --namespace default
   ```

   The Ingress should list your custom domain and associated service.

2. **Test Access:**

   Open a web browser and navigate to `http://<your-custom-domain>`. You should see the default NGINX welcome page or the "Hello from nginx-ingress" message if you customize it.

### 11. Customizing NGINX

If you want to display a custom message such as "Hello from nginx-ingress," you need to modify the content served by the NGINX container. You can do this by creating a custom Docker image or using a ConfigMap with a custom HTML file.

Here’s a quick example of using a ConfigMap to serve a custom HTML page:

1. **Create a ConfigMap:**

   Save the following as `nginx-configmap.yaml`:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: nginx-config
     namespace: default
   data:
     index.html: |
       <html>
       <body>
       <h1>Hello from nginx-ingress</h1>
       </body>
       </html>
   ```

   Apply the ConfigMap:

   ```sh
   kubectl apply -f nginx-configmap.yaml
   ```

2. **Update Deployment to Use ConfigMap:**

   Modify your `app-deployment.yaml` to use a volume from the ConfigMap:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: my-app
     namespace: default
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: my-app
     template:
       metadata:
         labels:
           app: my-app
       spec:
         containers:
         - name: my-app
           image: nginx:alpine
           ports:
           - containerPort: 80
           volumeMounts:
           - name: html
             mountPath: /usr/share/nginx/html
         volumes:
         - name: html
           configMap:
             name: nginx-config
   ```

   Apply the updated deployment:

   
   kubectl apply -f app-deployment.yaml
   ```

Now, navigating to your custom domain should show "Hello from nginx-ingress."

