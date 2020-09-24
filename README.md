# mlops
Artifacts for iter8's MLOps use cases, tutorials and blogs.

## Use the artifacts in this repo as follows.

### A) Create fashionmnist tensorflow models from jupyter notebook

Running [this notebook](https://github.com/iter8-tools/mlops/blob/master/tfserving.ipynb) requires python3 with and requires the tensorflow and jupyter notebook packages. You can create a python3 virtual environment, install the required packages, and open the notebook as follows.

1. `git clone git://github.com/iter8-tools/mlops.git`
2. `cd mlops`
3. `python3 -m venv .venv`
4. `source .venv/bin/activate`
5. `pip install tensorflow jupyterlab notebook`
6. `jupyter notebook tfserving.ipynb`

Running this notebook will create three tensorflow model instances for [the fashion mnist dataset](https://www.kaggle.com/zalando-research/fashionmnist). The models are saved under the folders `models/1`, `models/2`, and `models/3` respectively.

### B) Package the fashionmnist tensorflow models as docker images
1. `export MODEL_NAME=fashionmnist`
2. `export MODEL_VERSION=<model version>`
3. `export LOCAL_MODEL_DIR=models`
4. `export IMG=<name of your docker image>:v$MODEL_VERSION`
5. `make docker-build`

Note the relative path for the models folder and note the absence of the trailing slash. These are required. 

For example, if you run step 1, run step 2 as `export MODEL_VERSION=2`, run step 3, run step 4 as `export IMG=user/fashionmnist:v$MODEL_VERSION` and run step 5, you would have packaged version 2 of your model as the docker image `user/fashionmnist:v2`.

### C) Serve a model version locally on docker
1. `make docker-run`

This will serve a model version locally on docker. The name and tag of the image served is set in `IMG` environment variable in step A.1 above. You can set it to other values (e.g., `user/fashionmnist:v1`, or `user/fashionmnist:v2` or `user/fashionmnist:v3`) to serve different model versions.

### D) Push the docker image to your repo
1. `make docker-push`

This will `docker push` your image. The full name and tag of the image pushed is set in `IMG` environment variable in step A.1 above. You can set it to other values (e.g., `user/fashionmnist:v1`, or `user/fashionmnist:v2` or `user/fashionmnist:v3`) to push different model versions.

### E) Deploy version v1 of the fashionmnist model on a kubernetes cluster with Istio
This step assumes you have a kubernetes cluster accessible through the `kubectl` command and you have installed [Istio](https://istio.io) on this cluster.

1. `kubectl apply -f https://raw.githubusercontent.com/iter8-tools/mlops/master/modelv1.yaml`
2. `kubectl apply -f https://raw.githubusercontent.com/iter8-tools/mlops/master/externalize.yaml`

Step E.1 deploys version v1 of the fashionmnist model in your kubernetes cluster. You can alter the image in `modelv1.yaml` to use any other model image. Step E.2 externalizes it by creating a service and exposing the service outside the cluster through Istio's ingress gateway and virtual service.

### F) Send traffic to the model

Make sure you are running the jupyter notebook by following steps A.1 through A.6. Execute the first two cells which import appropriate python packages and and the image datasets. Execute the cell below the header `Send Serialized Images for Classification to the Model Service`. This will send a steady stream of traffic to the model service. For this to work, you need ensure you set the `gateway_url` variable in this cell correctly. It is currently intended to work for minikube environments. If your kubernetes environment is not minikube, follow the instructions in that cell to make sure `gateway_url` is set correctly.

### G) Deploy iter8's canary release experiment

1. `kubectl apply -f https://raw.githubusercontent.com/iter8-tools/mlops/master/fashionmnist-v2-rollout.yaml`

The experiment is created, but it is paused until the canary deployment is available.

### H) Deploy version v2 of the fashionmnist model on a kubernetes cluster with Istio

1. `kubectl apply -f https://raw.githubusercontent.com/iter8-tools/mlops/master/modelv2.yaml`

E, G, and H together trigger a canary release of version v2 of the fashion mnist model, and F ensures that there is application traffic to the model versions; without application traffic, there will no metrics computed for either of the versions, which can force iter8 to retain version v1 instead of rolling out v2.

After the experiment completes, you will see v2 safely rolled out and replacing v1.