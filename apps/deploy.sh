#!/usr/bin/env bash

set -eo pipefail

app="$(basename "$1")"

if [ ! -d "$app" ]; then
  echo "Unknown app \"$app\""
  exit 1
fi

echo "App: \"$app\""
cd "$app"

rendered_manifest="rendered.yml"

if [ ! -f "$rendered_manifest" ]; then
  echo "K8s manifest has not been rendered"
  exit 1
fi

final_manifest="$(mktemp)"
echo "Final manifest rendered to $final_manifest"

on_exit() {
  echo "Deleting $final_manifest"
  rm -f "$final_manifest"
}
trap on_exit EXIT

vals eval < "$rendered_manifest" > "$final_manifest"

kapp deploy \
  -a "$app" \
  -f "$final_manifest" \
  -c
