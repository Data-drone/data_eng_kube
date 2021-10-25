#!/bin/bash

kubectl create namespace airflow

# Do we need to create redis and postgres?
helm repo add apache-airflow https://airflow.apache.org

# Basic Setup
#helm install airflow apache-airflow/airflow --namespace airflow

# Advanced Setup
helm upgrade --cleanup-on-fail \
  --install airflow apache-airflow/airflow \
  --namespace airflow \
  --version=1.2.0 \
  --values airflow_operator/values.yaml