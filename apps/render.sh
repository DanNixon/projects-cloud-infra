#!/usr/bin/env bash

set -eo pipefail

find . -path './*/*' -name render.sh | while read -r script_path; do
  directory="$(dirname "$script_path")"
  echo ">>> $directory"

  pushd "$directory" > /dev/null
  ./render.sh
  popd > /dev/null
done
