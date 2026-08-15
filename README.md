# CORA-COMP tool skeleton

Minimal starting point for a CORA-COMP tool submission: the required scripts
(`install_tool.sh`, `prepare_instance.sh`, `run_instance.sh`) with argument parsing in
place and `TODO`s for your logic. It runs end-to-end as-is — a 1 s stand-in run that
writes a valid `finished` result — so you can submit it as a test tool before filling it
in.

Each instance names a set representation (`benchmark`, e.g. `zonotope` or its vectorized
`zonotope-batched` variant), an operation with its dimension, batch size, and device
(`instance`, e.g. `matMul-500d-b10-gpu`), how often to repeat it (`repetition`), where to
run it (`device`, `cpu` or `gpu`), and the operation's arguments as JSON (`params` —
carrying `batch_size` only on the batched benchmarks). Those columns are passed to your
scripts in that order, after the interface version. What each operation must do is defined
in the [benchmark catalog](https://github.com/CORA-COMP/benchmarks).

The skeleton reports `unsupported` for every `gpu` instance. Replace that once your library
runs on the GPU — falling back to the CPU instead would record a CPU number as a GPU
measurement.

See the toolkit info page of the [CORA-COMP
platform](https://github.com/CORA-COMP/cora-eval-platform) (`/toolkit/info` on the
deployment) for the submission pipeline, the script contract, and the results-file
format.
