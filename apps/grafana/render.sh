#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    grafana \
    grafana \
    --repo https://grafana.github.io/helm-charts \
    --version 6.48.0 \
    --namespace grafana \
    --values src/values.yml \
  | vals ksdecode -f -

  cat src/k8s/*.yml
} > rendered.yml
