#!/bin/bash
#SBATCH -J GCCM_PreNPP
#SBATCH -p INTEL_8581  
##SBATCH -p INTEL_8581                
#SBATCH -N 1                
#SBATCH -n 48
#SBATCH -o ./result/out_%j.log
#SBATCH -e ./result/error_%j.log

ulimit -l unlimited
Rscript GCCM_PreNPP.R