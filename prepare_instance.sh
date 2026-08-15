#!/bin/bash

# prepare_instance.sh — run before each instance.
# Arguments (the interface version, then the instance's instances.csv columns in file order):
# - $1: interface version string, e.g. "v1"
# - $2: benchmark,  the set representation, e.g. "zonotope"
# - $3: instance,   "<operation>-<n>d-<device>", e.g. "matMul-500d-gpu"
# - $4: repetition, how often to repeat the operation within this run, e.g. "100"
# - $5: device,     "cpu" or "gpu"
# - $6: params,     JSON object with the operation's arguments, e.g. '{"dim": 500, "device": "gpu"}'
# A column added to the catalog later arrives as a further argument, in file order.
#
# A nonzero exit code skips this instance.

set -e

VERSION_STRING="v1"
if [ "$1" != "$VERSION_STRING" ]; then
    echo "Expected first argument (version string) '$VERSION_STRING', got '$1'"
    exit 1
fi

BENCHMARK="$2"
INSTANCE="$3"
REPETITION="$4"
DEVICE="$5"
PARAMS="$6"

echo "Preparing $BENCHMARK / $INSTANCE on $DEVICE (x$REPETITION, params $PARAMS)"

# TODO: prepare anything this instance needs (start the runtime, warm caches, ...).
# This step is not timed; run_instance.sh is.

exit 0
