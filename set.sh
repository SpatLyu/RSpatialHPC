# View Ubuntu system information
echo "Viewing Ubuntu system information..."
lsb_release -a

# Check CPU information
echo "Checking CPU information..."
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c

# Update system indices
echo "Updating system indices..."
sudo apt update -qq

# Install necessary helper packages
echo "Installing helper packages..."
sudo apt install --no-install-recommends software-properties-common dirmngr -y

# Add the R project signing key
echo "Adding R project signing key..."
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

# Check if the previous command succeeded
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to add the R project signing key."
    read -p "Do you want to continue? (y/n): " continue
    if [[ ! "$continue" =~ ^[Yy]$ ]]; then
        echo "Exiting script."
        exit 1
    fi
fi

# Add the R 4.0 repository
echo "Adding R 4.0 repository..."
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Check if the previous command succeeded
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to add the R 4.0 repository."
    read -p "Do you want to continue? (y/n): " continue
    if [[ ! "$continue" =~ ^[Yy]$ ]]; then
        echo "Exiting script."
        exit 1
    fi
fi

# Install base R
echo "Installing base R..."
sudo apt install --no-install-recommends r-base r-base-dev -y

# Install R package dependencies
echo "Installing R package dependencies..."
sudo apt install libfontconfig1-dev libfreetype6-dev libcurl4-openssl-dev libssl-dev libxml2-dev libharfbuzz-dev libfribidi-dev libicu-dev libpng-dev libtiff5-dev libjpeg-dev libmagick++-dev libblas-dev liblapack-dev libarmadillo-dev -y
sudo apt install libmysqlclient-dev -y

# Add ubuntugis unstable PPA
echo "Adding ubuntugis unstable PPA..."
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable -y

# Check if the previous command succeeded
if [ $? -ne 0 ]; then
    echo "WARNING: Failed to add ubuntugis unstable PPA."
    read -p "Do you want to continue? (y/n): " continue
    if [[ ! "$continue" =~ ^[Yy]$ ]]; then
        echo "Exiting script."
        exit 1
    fi
fi

# Install additional R package dependencies
echo "Installing additional R package dependencies..."
sudo apt install libudunits2-dev libgdal-dev libgeos-dev libproj-dev libsqlite3-dev -y

# Ask the user if they want to install RStudio Server
read -p "Do you want to install RStudio Server? (y/n): " install_rstudio
if [[ "$install_rstudio" =~ ^[Yy]$ ]]; then
    echo "Installing RStudio Server..."
    sudo apt install gdebi-core -y
    wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.12.0-467-amd64.deb
    sudo gdebi rstudio-server-2024.12.0-467-amd64.deb -n
else
    echo "Skipping RStudio Server installation."
fi

# Set up R package installation path
echo "Setting up R package installation path..."
cd ~

# Check if ~/home/pkgR exists
if [ -d "~/home/pkgR" ]; then
    echo "Directory ~/home/pkgR already exists. Using ~/home/pkgRUserLocal instead."
    mkdir -p ~/home/pkgRUserLocal
    R_LIB_PATH="~/home/pkgRUserLocal"
else
    echo "Directory ~/home/pkgR does not exist. Using ~/home/pkgR."
    mkdir -p ~/home/pkgR
    R_LIB_PATH="~/home/pkgR"
fi

# Write the .libPaths() configuration to ~/.Rprofile
echo "Configuring .libPaths() in ~/.Rprofile..."
echo ".libPaths(c(\"$R_LIB_PATH\", .libPaths()))" >> ~/.Rprofile

# Verify the .Rprofile configuration
echo "Current ~/.Rprofile content:"
cat ~/.Rprofile

# Restart R to apply the new .libPaths() settings
echo "Restarting R to apply the new library paths..."
Rscript -e 'quit(save="no")'

# Install R packages
echo "Installing R packages..."

# # Function to install an R package
# install_r_package() {
#     local package_name=$1  # Get the package name from the first argument

#     echo "Installing R package: $package_name..."
#     Rscript -e "install.packages('$package_name', repos = 'https://mirrors.bfsu.edu.cn/CRAN/', dep = TRUE)"

#     # Check if the installation succeeded
#     if [ $? -ne 0 ]; then
#         echo "ERROR: Failed to install R package: $package_name."
#         read -p "Do you want to retry? (y/n): " retry
#         if [[ "$retry" =~ ^[Yy]$ ]]; then
#             install_r_package "$package_name"  # Retry installation
#         else
#             echo "Skipping installation of $package_name."
#         fi
#     else
#         echo "R package $package_name installed successfully."
#     fi
# }

# Function to install an R package with retry logic
install_r_package() {
    local package_name=$1  # Get the package name from the first argument
    local max_retries=5     # Maximum number of retries
    local attempt=1         # Current attempt

    echo "Installing R package: $package_name..."

    while [ $attempt -le $max_retries ]; do
        # Try to install the package
        Rscript -e "install.packages('$package_name', repos = 'https://mirrors.bfsu.edu.cn/CRAN/')"

        # Check if the installation succeeded
        if [ $? -eq 0 ]; then
            echo "R package $package_name installed successfully."
            return 0  # Exit function after successful installation
        fi

        # If installation failed
        echo "ERROR: Failed to install R package: $package_name (Attempt $attempt of $max_retries)."
        
        # If 5 attempts failed, prompt for continuation
        if [ $attempt -eq 5 ]; then
            read -p "5 attempts failed. Do you want to continue? (y/n): " continue
            if [[ "$continue" =~ ^[Yy]$ ]]; then
                echo "Continuing with the next package..."
                return 1  # Exit and continue with the next package
            else
                echo "Skipping installation of $package_name."
                return 1  # Exit the function and skip the current package
            fi
        fi

        # Prompt to retry after each failure
        if [[ "$attempt" -lt 3 ]]; then
            read -p "Do you want to retry? (y/n): " retry
            if [[ "$retry" =~ ^[Yy]$ ]]; then
                ((attempt++))  # Increment the attempt counter
                continue  # Retry the installation
            else
                echo "Skipping installation of $package_name."
                return 1  # Exit the function and skip the current package
            fi
        elif [[ "$attempt" -ge 3 && "$attempt" -lt 5 ]]; then
            read -p "3 attempts failed. Do you want to continue with the next package? (y/n): " continue
            if [[ "$continue" =~ ^[Yy]$ ]]; then
                echo "Continuing with the next package..."
                return 1  # Exit and continue with the next package
            else
                echo "Skipping installation of $package_name."
                return 1  # Exit the function and skip the current package
            fi
        fi
    done
}

install_r_package "remotes"
install_r_package "sf"
install_r_package "terra"

Rscript -e 'remotes::install_github("stscl/spEDM",dep = TRUE)'

echo "All tasks completed!"