#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    promtail \
    promtail \
    --repo https://grafana.github.io/helm-charts \
    --version "6.6.0" \
    --namespace promtail \
    --values src/values.yml \
  | vals ksdecode -f -

  cat src/k8s/*.yml
} > rendered.yml
