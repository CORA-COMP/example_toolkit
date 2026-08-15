#!/bin/bash

# run_instance.sh — run your library on a single instance and report the verdict.
# Arguments (the interface version, then the instance's instances.csv columns in file order):
# - $1: interface version string, e.g. "v1"
# - $2: benchmark,  the set representation, e.g. "zonotope"
# - $3: instance,   "<operation>-<n>d", e.g. "matMul-500d"
# - $4: repetition, how often to repeat the operation within this run, e.g. "100"
# - $5: params,     JSON object with the operation's arguments, e.g. '{"dim": 500}'
# A column added to the catalog later arrives as a further argument, in file order, and
# the results file to write is always the LAST argument.
#
# The harness owns timing: it measures the wall-clock time of this script and enforces
# the per-instance timeout (the "timeout" column in instances.csv, if the catalog sets
# one; otherwise the run is uncapped). Do not sleep to a deadline yourself.
#
# Repeat the operation $REPETITION times inside this script, so one measurement averages
# over repeats rather than timing a single noisy call.

set -e

VERSION_STRING="v1"
if [ "$1" != "$VERSION_STRING" ]; then
    echo "Expected first argument (version string) '$VERSION_STRING', got '$1'"
    exit 1
fi

BENCHMARK="$2"
INSTANCE="$3"
REPETITION="$4"
PARAMS="$5"
# The results file is always the last argument.
RESULTS_FILE="${@: -1}"

# The instance name carries the operation; its arguments come from the params JSON.
# python3 is always present on the worker (the harness itself runs on it).
OPERATION="${INSTANCE%%-*}"
DIM=$(printf '%s' "$PARAMS" | python3 -c 'import json,sys; print(json.load(sys.stdin)["dim"])')

echo "Running $OPERATION on $BENCHMARK in ${DIM}d, x$REPETITION -> $RESULTS_FILE"

# Stand-in for the actual run (~1s of "execution") so the skeleton is runnable as-is and
# usable as a test tool before you fill it in.
# TODO: replace this with the real invocation — dispatch on $OPERATION
# (generateRandom / matMul / minkSum / ...) for the $BENCHMARK set representation in
# dimension $DIM, repeated $REPETITION times. See the benchmark catalog for what each
# operation must do: https://github.com/CORA-COMP/benchmarks
sleep 1

VERDICT="unknown"   # one of: verified, falsified, unknown, error

# Write the results file: a header row plus one data row with a "result" column. Any
# further columns you add are kept per instance alongside the verdict, so a library can
# report its own breakdown next to the harness wall-clock:
#   printf 'result,time_generate,time_operation\n' > "$RESULTS_FILE"
#   printf '%s,%s,%s\n' "$VERDICT" "$t_gen" "$t_op" >> "$RESULTS_FILE"
printf 'result\n%s\n' "$VERDICT" > "$RESULTS_FILE"
