# mlops
Artifacts for iter8's MLOps use cases, tutorials and blogs.

## This repo consists of the following artifacts.

### [Tensorflow model creation jupyter notebook](https://github.com/iter8-tools/mlops/blob/master/tfmodelcreation.ipynb)

Running this notebook requires python3 and the numpy, tensorflow, and jupyter notebook packages. You can create a python3 virtual environment, install the required packages, and open the notebook as follows.

1. `git clone git://github.com/iter8-tools/mlops.git`
2. `cd mlops`
3. `python3 -m venv .venv`
4. `source .venv/bin/activate`
5. `pip install tensorflow jupyterlab notebook`
6. `jupyter notebook tfmodelcreation.ipynb`

Running this notebook will create three tensorflow models for the fashion mnist dataset and store it under the folders `mlops/models/1`, `mlops/models/2`, and `mlops/models/3` respectively.