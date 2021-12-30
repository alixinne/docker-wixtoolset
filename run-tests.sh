#!/bin/bash

set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-vtavernier/wixtoolset:latest}"

if hash podman >/dev/null 2>&1; then
  DOCKER=podman
  VOL=:z
else
  DOCKER=docker
  VOL=""
fi

docker_run () {
  echo "run: $@" >&2
  $DOCKER run --rm -it -v "$PWD:/src$VOL" "$IMAGE_NAME" "$@"
}

run_test () {
  (
    set -euo pipefail
    cd "$1"

    # Clean temporary files
    rm -f *.wixobj

    # Run candle
    docker_run candle -nologo Main.wxs

    # Check if candle succeeded before proceeding
    if [ -f Main.wixobj ]; then
      # Run light
      docker_run light -nologo -sval Main.wixobj
    else
      echo "Not running light since candle failed." >&2
      exit 1
    fi
  )
}

FAILED_TESTS=0

for TEST_DIR in tests/*; do
  echo "$TEST_DIR" >&2
  if run_test "$TEST_DIR"; then
    echo -e "\e[32m$TEST_DIR: success\e[0m" >&2
  else
    echo -e "\e[31m$TEST_DIR: failed\e[0m" >&2
    FAILED_TESTS=$((FAILED_TESTS + 1))
  fi
done

if [ $FAILED_TESTS -gt 0 ]; then
  exit 1
fi
