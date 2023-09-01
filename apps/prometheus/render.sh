#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    prometheus \
    prometheus \
    --repo https://prometheus-community.github.io/helm-charts \
    --version 15.17.0 \
    --namespace prometheus \
    --values src/values.yml \
  | vals ksdecode -f -

  cat src/k8s/*.yml
} > rendered.yml
