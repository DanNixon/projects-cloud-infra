#!/bin/sh

echo """
apiVersion: v1
kind: Namespace
metadata:
  name: kapp
""" | kubectl apply -f -
