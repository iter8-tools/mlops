# mlops
Artifacts for iter8's MLOps use cases, tutorials and blogs.

## Use the artifacts in this repo as follows.

### A) Create fashion_mnist tensorflow models from jupyter notebook

Running [this notebook](https://github.com/iter8-tools/mlops/blob/master/tfmodelcreation.ipynb) requires python3 with and requires the tensorflow and jupyter notebook packages. You can create a python3 virtual environment, install the required packages, and open the notebook as follows.

1. `git clone git://github.com/iter8-tools/mlops.git`
2. `cd mlops`
3. `python3 -m venv .venv`
4. `source .venv/bin/activate`
5. `pip install tensorflow jupyterlab notebook`
6. `jupyter notebook tfmodelcreation.ipynb`

Running this notebook will create three tensorflow model instances for [the fashion mnist dataset](https://www.kaggle.com/zalando-research/fashionmnist). The models are saved under the folders `models/1`, `models/2`, and `models/3` respectively.

### B) Package the fashion_mnist tensorflow models as docker images
1. `export MODEL_NAME=fashion_mnist`
2. `export MODEL_VERSION=<model version>`
3. `export LOCAL_MODEL_DIR=models`
4. `export IMG=<name of your docker image>:v$MODEL_VERSION`
5. `make docker-build`

Note the relative path for the models folder and note the absence of the trailing slash. These are required. 

For example, if you run step 1, run step 2 as `export MODEL_VERSION=2`, run step 3, run step 4 as `export IMG=user/fashion_mnist:v$MODEL_VERSION` and run step 5, you would have packaged version 2 of your model as the docker image `user/fashion_mnist:v2`.

### C) Serve a model version locally on docker
1. `make docker-run`

This will serve a model version locally on docker. The name and tag of the image served is set in `IMG` environment variable in step A.1 above. You can set it to other values (e.g., `user/fashion_mnist:v1`, or `user/fashion_mnist:v2` or `user/fashion_mnist:v3`) to serve different model versions.

### D) Deploy a model version on a kubernetes cluster with Istio
This step assumes you have a kubernetes cluster accessible through `kubectl` and you have installed [Istio](https://istio.io) on this cluster.

1. `make deploy`

This command deploys version v1 of the model on your kubernetes cluster with Istio, and subsequently exposes it outside the cluster so that it can receive prediction requests. You can deploy other versions by changing the image used within `baseline.yaml`.