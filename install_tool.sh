#!/bin/bash

# install_tool.sh — run once on the worker to install your tool.
#
# CORA-COMP tools run inside a Docker base image you name on the submission form; the
# platform clones this repository into that image and then runs this script. It is the
# place for dependencies, builds, and license activation.
#
# Argument:
# - $1: interface version string, e.g. "v1"

set -e

VERSION="${1:-v1}"
echo "Installing tool (interface $VERSION)"

# TODO: install your tool's dependencies and activate any license here.
