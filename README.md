# mlops
Artifacts for iter8's MLOps use cases, tutorials and blogs.

## Use the artifacts in this repo as follows.

### Create fashion_mnist tensorflow models from jupyter notebook

Running [this notebook](https://github.com/iter8-tools/mlops/blob/master/tfmodelcreation.ipynb) requires python3 with and requires the tensorflow and jupyter notebook packages. You can create a python3 virtual environment, install the required packages, and open the notebook as follows.

1. `git clone git://github.com/iter8-tools/mlops.git`
2. `cd mlops`
3. `python3 -m venv .venv`
4. `source .venv/bin/activate`
5. `pip install tensorflow jupyterlab notebook`
6. `jupyter notebook tfmodelcreation.ipynb`

Running this notebook will create three tensorflow model instances for [the fashion mnist dataset](https://www.kaggle.com/zalando-research/fashionmnist). The models are saved under the folders `models/1`, `models/2`, and `models/3` respectively.

### Package the fashion_mnist tensorflow models as docker images
1. `export IMG=<name of your docker image>`
2. `export MODEL_NAME=fashion_mnist`
3. `export LOCAL_MODEL_DIR=models`
4. `export MODEL_VERSION=<model version>`
5. `make docker-build`

Note the relative path for the models folder and note the absence of the trailing slash. These are required. 

For example, in step 1, if you `export IMG=my_docker_account/fashion_mnist:v2` in step 1, run steps 2 and 3, and in step 4 `export MODEL_VERSION=2` and run step 5, you would have packaged version 2 of your model as the docker image `my_docker_account/fashion_mnist:v2`.

### Run the docker image
`make docker-run`

This will run docker image named `IMG` in detached mode.