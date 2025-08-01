conda create -n rspatial -y
conda activate rspatial
conda install mamba -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-base r-essentials r-devtools r-languageserver -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-sf r-terra r-spatialreg r-spdep -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-xml r-plot3d r-ncdf4 r-fasterize r-writexl -y
# mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-lwgeom -y
# Rscript - e "install.packages('tmap', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('RcppArmadillo', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('terra', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('sgsR', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('spEDM_1.8.tar.gz', repos = NULL, type = 'source')"

conda create -n pyspatial python=3.11 -y
conda activate pyspatial
conda install mamba -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge pysal ipykernel -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge openpyxl xlwt xlrd ruptures mpart -y

# build r pkgs in phadcloud
# srun --partition=INTEL_8581 --nodes=1 --ntasks=1 --time=1:00:00 --pty bash

# install.packages('spEDM_1.8.tar.gz', repos = NULL, type = 'source')
# install.packages('tEDM_1.1.tar.gz', repos = NULL, type = 'source')