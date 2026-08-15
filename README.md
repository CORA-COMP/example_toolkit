# CORA-COMP tool skeleton

Minimal starting point for a CORA-COMP tool submission: the required scripts
(`install_tool.sh`, `prepare_instance.sh`, `run_instance.sh`) with argument parsing in
place and `TODO`s for your logic. It runs end-to-end as-is — a 1 s stand-in run that
writes a valid `finished` result — so you can submit it as a test tool before filling it
in.

Each instance names a set representation (`benchmark`, e.g. `zonotope` or its vectorized
`zonotope-batched` variant), the case within it (`instance`, e.g. `matMul-500d-b10-gpu`),
how often to repeat the operation (`repetition`), and everything the operation needs as
JSON (`params`: `operation`, `dim`, `device`, plus `batch_size` on the batched
benchmarks). Those columns are passed to your scripts in that order, after the interface
version. Dispatch on `params` rather than on the instance name, which only repeats the
same facts in readable form. What each operation must do is defined in the
[benchmark catalog](https://github.com/CORA-COMP/benchmarks).

## What goes where

The harness measures the wall-clock time of `run_instance.sh` alone, so the split between
the two per-instance scripts is what decides what gets measured:

- **`prepare_instance.sh` generates the inputs** and writes them to disk — for `matMul`, the
  random matrix and the random set. This step is not timed.
- **`run_instance.sh` reads them back once and then performs the operation `repetition`
  times** — for `matMul`, only the multiplication. Nothing else belongs here.

`generateRandom` and `startup` are the exceptions: the initialization *is* the operation,
so there is nothing to prepare.

The skeleton reports `unsupported` for every `gpu` instance. Replace that once your library
runs on the GPU — falling back to the CPU instead would record a CPU number as a GPU
measurement.

See the toolkit info page of the [CORA-COMP
platform](https://github.com/CORA-COMP/cora-eval-platform) (`/toolkit/info` on the
deployment) for the submission pipeline, the script contract, and the results-file
format.
