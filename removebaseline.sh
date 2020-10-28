#!/bin/bash

kubectl delete -f https://raw.githubusercontent.com/iter8-tools/mlops/master/modelv1.yaml
kubectl delete -f https://raw.githubusercontent.com/iter8-tools/mlops/master/externalize.yaml