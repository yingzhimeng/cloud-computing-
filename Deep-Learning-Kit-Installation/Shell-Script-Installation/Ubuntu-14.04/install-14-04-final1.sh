#!/bin/bash

# ---------------------------------------------------------------------------------- #
# 			Script to set up a Deep Learning VM on Google Cloud Platform			 #
#           ------------------------------------------------------------			 #
#Autor:             Amir Jafari, Michael Arango, Prince Birring						 #
#Date:              09/23/2017						                                 #
#Organization:      George Washington University                                     #
# INSTRUCTIONS: When you run this script, make sure you include the username 		 #
# 				associated with your instance as the first parameter. Otherwise,	 #
# 				the softwares will not work properly.   							 #
# ---------------------------------------------------------------------------------- #

# ------------------------ Cuda Installation ------------------------

# Update packages
sudo apt update
# Instal chromium browser
sudo apt install -y chromium-browser
# Download Cuda .deb file from Google Storage bucket
wget https://storage.googleapis.com/cuda-deb/cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64.deb
# Unpack the deb file
sudo dpkg -i cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64.deb
# Update the packages
sudo apt-get update
# Install cuda
sudo apt-get install -y cuda
# Install all required linux headers
sudo apt-get install -y linux-headers-$(uname -r)
# Remove the first line from the global environment 
sed 1d /etc/environment > /etc/environment
# Add your path to the global environment
echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/cuda-8.0/bin"' >> /etc/environment
# Execute the global environment 
source /etc/environment
# Check the version of Cuda to see it is installed
nvcc --version
# Check that the graphics card driver is installed and working with the GPU
nvidia-smi

# ------------------------ CuDNN Installation ------------------------

# Download the CuDNN .deb file from the Google Storage bucket  
wget https://storage.googleapis.com/cuda-deb/cudnn-8.0-linux-x64-v6.0.tgz
# Untar the download file
tar -zxf cudnn-8.0-linux-x64-v6.0.tgz
# Change into the Cuda directory
cd cuda
# Copy the files from the download directory into the user directory
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/* /usr/local/cuda/include/
# Check to see if CuDNN is installed
cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2
# Change one directory upward
cd ..

# -------------------- Python Required Package Installations --------------------

# --- Python2 pip and packages
sudo apt-get install -y python-pip python-dev
sudo apt-get install -y python-tk
sudo apt-get install -y python-matplotlib
sudo apt-get install -y python-pandas
sudo apt-get install -y python-sklearn
sudo apt-get install -y python-skimage
sudo apt-get install -y python-h5py
sudo apt-get install -y python-leveldb
sudo apt-get install -y python-protobuf
sudo apt-get install -y python-gflags
sudo pip install --upgrade pip
sudo pip install networkx
sudo pip install seaborn
sudo pip install cython

# install packages to zip and unzip files 
sudo apt-get install -y p7zip-full
sudo apt install unzip

# ------------------------ Pycharm Installation ------------------------

# Download .deb file from google storage bucket
wget https://storage.googleapis.com/cuda-deb/pycharm-community_2016.3-mm1_all.deb
# unpack the contents
sudo dpkg -i pycharm-community_2016.3-mm1_all.deb

 ------------------------ Torch Installation ------------------------

# install git
sudo apt install git -y
# clone the torch github repo 
git clone https://github.com/torch/distro.git ~/torch --recursive
# Change into the torch repo
cd ~/torch 
# run the dependency install
bash install-deps
# run the install script 
./install.sh
# Change back into the root directory
cd ..
# Execute the .bashrc script
source ~/.bashrc
# Install the Lua package manager
sudo apt-get install -y luarocks
# Install Lua packages in the luarocks directory
sudo ~/torch/install/bin/luarocks install torch 
sudo ~/torch/install/bin/luarocks install image 
sudo ~/torch/install/bin/luarocks install nngraph
sudo ~/torch/install/bin/luarocks install optim
sudo ~/torch/install/bin/luarocks install nn
sudo ~/torch/install/bin/luarocks install cutorch
sudo ~/torch/install/bin/luarocks install cunn
sudo ~/torch/install/bin/luarocks install cunnx
sudo ~/torch/install/bin/luarocks install dp
# Install these packages and their dependencies, but not other recommended ones
sudo apt-get install --no-install-recommends libhdf5-serial-dev liblmdb-dev
# Install more Lua packages/files in the luarocks directory
sudo ~/torch/install/bin/luarocks install tds
sudo ~/torch/install/bin/luarocks install "https://raw.github.com/deepmind/torch-hdf5/master/hdf5-0-0.rockspec"
sudo ~/torch/install/bin/luarocks install "https://raw.github.com/Neopallium/lua-pb/master/lua-pb-scm-0.rockspec"
sudo ~/torch/install/bin/luarocks install lightningmdb 0.9.18.1-1 LMDB_INCDIR=/usr/include LMDB_LIBDIR=/usr/lib/x86_64-linux-gnu
sudo ~/torch/install/bin/luarocks install "httpsraw.githubusercontent.comngimelnccl.torchmasternccl-scm-1.rockspec"
# Clone the git repo of torch demos
git clone https://github.com/torch/demos
# Install library
sudo apt-get install gnuplot-x11
# Update libraries 
sudo apt update

# ------------------------ ZeroBrane Studio Installation ------------------------

# Download shell script form google storage bucket
wget https://storage.googleapis.com/cuda-deb/ZeroBraneStudioEduPack-1.60-linux.sh
# Make the script executable
chmod +x ZeroBraneStudioEduPack-1.60-linux.sh
# Run the shell script
./ZeroBraneStudioEduPack-1.60-linux.sh

# ------------------------ Caffe Installation ------------------------

# Install dependencies
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev \
    					libopencv-dev libboost-all-dev libhdf5-serial-dev \
    					protobuf-compiler gfortran libjpeg62 libfreeimage-dev \
    					libatlas-base-dev git python-dev python-pip \
    					libgoogle-glog-dev libbz2-dev libxml2-dev libxslt-dev \
    					libffi-dev libssl-dev libgflags-dev liblmdb-dev \
    					python-yaml python-numpy
# Install pillow
sudo easy_install pillow
# Change to root directory
cd ~
# Clone the BVLC Caffe repo
git clone https://github.com/BVLC/caffe.git
# Change into the caffe repo directory
cd caffe
# Install all python requirements in the requirements.txt file
cat python/requirements.txt | xargs -L 1 sudo pip install
# Make a copy of the Makefile to use
cp Makefile.config.example Makefile.config
# Uncomment the line to use CuDNN
sed -i '/^# USE_CUDNN := 1/s/^# //' Makefile.config
# Make Caffe from the rules in the makefile using 8 cores
make pycaffe -j8
make all -j8
make test -j8
# Export the path to .bashrc and source it 
echo "export PYTHONPATH=/home/$1/caffe/python" >> ~/.bashrc
source ~/.bashrc
# Create a link between the 2 files
sudo ln /dev/null /dev/raw1394
# Install more python dependencies
sudo apt-get install -y python-skimage
sudo apt-get install -y python-pydot
sudo apt-get install -y python-protobuf 
# Change back to the root directory
cd ..

# ------------- Tensorflow - Python 2.7.X -------------

sudo pip install --upgrade tensorflow-gpu


# ----------------- Theano Installation -----------------

# Install Theano (Python2)
sudo pip install Theano 
# Download tar file from google storage bucket
wget https://storage.googleapis.com/cuda-deb/six-1.11.0.tar.gz
# Untar the file
tar -zxf six-1.11.0.tar.gz
# Change into the new directory
cd six-1.11.0
# run the setup script
sudo python setup.py install
# Change back to the root directory
cd ..
# Install Theano (Python3)
#sudo pip3 install Theano 

# ----------------- Keras Installation -----------------

# Python 2
sudo pip install keras

# ----------------- Pytorch Installation -----------------

# Install PyTorch (Python 2 ) from wheel file
sudo pip install http://download.pytorch.org/whl/cu80/torch-0.2.0.post3-cp27-cp27mu-manylinux1_x86_64.whl 
sudo pip install torchvision 
