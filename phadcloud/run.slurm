#!/bin/bash
#SBATCH -J SCPCM
#SBATCH -p INTEL_8581  
##SBATCH -p INTEL_8581                
#SBATCH -N 1                
#SBATCH -n 32
#SBATCH -o ./out_%j.log
#SBATCH -e ./error_%j.log

ulimit -l unlimited
Rscript ./script.r