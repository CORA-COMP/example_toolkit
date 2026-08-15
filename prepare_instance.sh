#!/bin/bash

# prepare_instance.sh — build this instance's inputs, before the timed run.
# Arguments (the interface version, then the instance's instances.csv columns in file order):
# - $1: interface version string, e.g. "v1"
# - $2: benchmark,  the set representation, e.g. "zonotope" or "zonotope-batched"
# - $3: instance,   "<operation>-<n>d[-b<batch>]-<device>", e.g. "matMul-500d-b10-gpu"
# - $4: params,     JSON object with everything the tool needs, e.g. '{"set": "zonotope",
#                   "operation": "matMul", "dim": 500, "device": "gpu", "repetition": 100,
#                   "batch_size": 10}'
# A column added to the catalog later arrives as a further argument, in file order.
#
# This step is NOT timed. It is where the operation's *inputs* are generated and written
# to disk, so that run_instance.sh performs — and the harness measures — only the
# operation itself. For matMul that means generating the random matrix and the random set
# here; run_instance.sh reads them back and multiplies.
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
PARAMS="$4"

# Everything the tool needs is in the params JSON; the benchmark and instance names only
# repeat it in readable form. python3 is always present on the worker (the harness itself
# runs on it). batch_size is absent on the unbatched benchmarks, hence the default of 1.
read -r SET OPERATION DIM DEVICE BATCH_SIZE <<EOF
$(printf '%s' "$PARAMS" | python3 -c 'import json,sys; p=json.load(sys.stdin); print(p["set"], p["operation"], p["dim"], p["device"], p.get("batch_size", 1))')
EOF

# Handover point to run_instance.sh, which derives the same path. Both scripts run with
# the tool directory as their working directory, so a relative path is stable.
mkdir -p inputs
INPUT_FILE="inputs/${BENCHMARK}-${INSTANCE}.input"

echo "Preparing $OPERATION on $SET in ${DIM}d, batch $BATCH_SIZE, on $DEVICE"

# TODO: call your library to generate the inputs $OPERATION takes, and write them to
# "$INPUT_FILE". Pass it $OPERATION, $SET, $DIM, $BATCH_SIZE and $DEVICE, and let it
# dispatch on the operation itself. The catalog says what each operation is given.

# The 1 s stand-in below keeps the skeleton runnable as a test tool until you do; delete it.
sleep 1

exit 0
