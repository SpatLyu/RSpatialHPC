#!/bin/bash
#SBATCH -J BuildVignettes
#SBATCH -p INTEL_8581  
##SBATCH -p INTEL_8581                
#SBATCH -N 1                
#SBATCH -n 36
#SBATCH -o ./result/out_%j.log
#SBATCH -e ./result/error_%j.log

ulimit -l unlimited
Rscript ./build_vignettes.r