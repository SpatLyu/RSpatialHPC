#!/bin/bash
#SBATCH -J test
#SBATCH -p TEST_INTEL_8581            ##8581C分区测试队列
##SBATCH -p INTEL_8581                ##8581C分区正式队列
#SBATCH --nodes=1                     ##指定节点数
#SBATCH --ntasks-per-node=32          ##指定核心数
#SBATCH -o out_%j.log
#SBATCH -e error_%j.log

ulimit -l unlimited
Rscript test.r