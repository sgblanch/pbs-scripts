# pbs-scripts

User prologue and epilogue scripts for torque-based clusters.

## Installation

* Clone this repository and make both the prologue and epilogue scripts executable

```bash
git clone https://github.com/sgblanch/pbs-scripts.git "$HOME/.pbs-scripts"
chmod 750 "$HOME/.pbs-scripts/"{prologue,epilogue}.sh
```
* Alias the `qsub` command in your `.bashrc` file so the prologue and epilogue scripts are automatically added to all jobs submitted to the cluster.

```bash
if command -v qsub > /dev/null 2>&1 && \
		[[ -x "${HOME}/.pbs-scripts/prologue.sh" ]] && \
		[[ -x "${HOME}/.pbs-scripts/epilogue.sh" ]]; then
        alias qsub="qsub -l prologue=${HOME}/.pbs-scripts/prologue.sh -l epilogue=${HOME}/.pbs-scripts/epilogue.sh"
fi
```
