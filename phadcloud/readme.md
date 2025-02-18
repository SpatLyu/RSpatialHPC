```
conda activate rspatial
```

Then, select the slurm script and run:

```bash
sbatch run.slurm
```

If the HPC throw the error of `sbatch: error: Batch script contains DOS line breaks (\r\n) \\n sbatch: error: instead of expected UNIX line breaks (\n).`, try :

```bash
sed -i 's/\r$//' run.slurm
```     