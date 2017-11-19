# Ubuntu 14.04 steps to run the shell script

## Getting Started 

To install all the Frameworks (torch, caffe, tensorflow, theano, pytorch), launch your VM  and run the following commands in order in to your VM terminal.

```
sudo apt-get install git -y
```
```
git clone https://github.com/amir-jafari/Cloud-Computing.git
```
```
cd Cloud-Computing/Deep-Learning-Kit-Installation/Shell-Script-Installation/Ubuntu-14.04/

```
```
mv install-14-04-final1.sh ~
```
```
cd ~
```
```
chmod +x install-14-04-final1.sh
```
```
sudo ./install-14-04-final1.sh <netid or username of ssh key>
```

## Testing the framworks

* Torch

Run the following commands

```
source /etc/environment
```
```
source ~/.bashrc
```
then to test torch just enter
```
sudo ~/torch/install/bin/luarocks install torch 
```

```
th
```
in to your terminal and you should be able to see the torch environment. Now enter 
```
require 'dp'
```
if torch is is installed correctly then you should be see a long list. Then type
```
exit
```
and then enter y to get out of the torch env.

* Caffe

Enter the following command on your terminal
```
sudo ln /dev/null /dev/raw1394
```
```
sudo rm -rf /dev/raw1394
```
```
python
```
then in the python env write
```
import caffe
```
exit out from python env by exit()

* Tensorflow, Keras, Theano (python 2.7)

Enter the following command on your terminal
```
sudo pip install --upgrade tensorflow-gpu
```
```
python
```
then in the python env write
```
import tensorflow
```
```
import keras
```
```
import theano
```
if you did not get any error then exit out from python env by exit().


* Pytorch (python 2.7)

Enter the following command on your terminal
```
python
```
then in the python env write
```
import torch
```
```
import torchvision
```
if you did not get any error then exit out from python env by exit().

* Pycharm and ZeroBraneStudio

Note: Mac users need to acivate [Xquartz](https://www.xquartz.org/) in their machine and then open your terminal. In other words, when you are ssh ing to VM use -X as follows:

```
ssh -X -i <private key file > <netid>@<External Ip address>
``` 

Note: Windows users use Mobaexterma and you are fine.

To activate pycharm enter the following commands:

```
pycharm-community
```

To activate ZeroBraneStudio:

```
zbstudio
```


