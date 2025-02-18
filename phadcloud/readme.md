```
conda activate rspatial
```

Then, select the slurm script and run:

```bash
sbatch run.slurm
```

If the HPC throws the error of 

```bash
sbatch: error: Batch script contains DOS line breaks (\r\n) 
sbatch: error: instead of expected UNIX line breaks (\n).
```

try :

```bash
sed -i 's/\r$//' run.slurm
```     