conda create -n rspatial -y
conda activate rspatial
conda install mamba -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-base=4.5.0 r-essentials r-devtools r-languageserver -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-sf r-terra r-spatialreg r-spdep -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-xml r-plot3d r-ncdf4 r-fasterize r-writexl -y
# mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge r-lwgeom -y
# Rscript - e "install.packages('tmap', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('RcppArmadillo', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('terra', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('sgsR', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"
# Rscript - e "install.packages('spEDM_1.7.tar.gz', repos = NULL, type = 'source')"

conda create -n pyspatial python=3.11 -y
conda activate pyspatial
conda install mamba -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge pysal ipykernel -y
mamba install -c https://mirrors.sustech.edu.cn/anaconda/cloud/conda-forge openpyxl xlwt xlrd ruptures mpart -y