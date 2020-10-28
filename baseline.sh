#!/bin/bash

kubectl label namespace default istio-injection=enabled
kubectl apply -f https://raw.githubusercontent.com/iter8-tools/mlops/master/modelv1.yaml
kubectl apply -f https://raw.githubusercontent.com/iter8-tools/mlops/master/externalize.yaml