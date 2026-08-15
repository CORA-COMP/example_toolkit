# CORA-COMP tool skeleton

Minimal starting point for a CORA-COMP tool submission: the required scripts
(`install_tool.sh`, `prepare_instance.sh`, `run_instance.sh`) with argument parsing in
place and `TODO`s for your logic. It runs end-to-end as-is — a 1 s stand-in run that
writes a valid `unknown` result — so you can submit it as a test tool before filling it
in.

Each instance names a set representation (`benchmark`), an operation and dimension
(`instance`, e.g. `matMul-500d`), how often to repeat it (`repetition`), and the
operation's arguments as JSON (`params`). Those columns are passed to your scripts in
that order, after the interface version. What each operation must do is defined in the
[benchmark catalog](https://github.com/CORA-COMP/benchmarks).

See the toolkit info page of the [CORA-COMP
platform](https://github.com/CORA-COMP/cora-eval-platform) (`/toolkit/info` on the
deployment) for the submission pipeline, the script contract, and the results-file
format.
