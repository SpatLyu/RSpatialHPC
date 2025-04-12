conda create -n rspatial
conda activate rspatial
conda install mamba -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-base=4.4.3 r-essentials r-devtools r-languageserver -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-sf r-terra r-spatialreg r-spdep -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-xml r-ncdf4 r-fasterize r-writexl -y
Rscript - e "install.packages('RcppArmadillo', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
Rscript - e "install.packages('terra', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
Rscript - e "install.packages('sgsR', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
Rscript - e "install.packages('spEDM_1.6.tar.gz', repos = NULL, type = 'source')"