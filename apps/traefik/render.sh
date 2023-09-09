#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    traefik \
    traefik \
    --repo https://helm.traefik.io/traefik \
    --version "24.0.0" \
    --namespace traefik \
    --values src/values.yml

  cat src/k8s/*.yml
} > rendered.yml
