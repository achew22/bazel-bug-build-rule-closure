#! /usr/bin/env bash

set -e

echo "Building using closure build rules"

cd /data
/bazel/output/bazel build //demo:hello
