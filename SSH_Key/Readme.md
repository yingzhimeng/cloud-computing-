# SSH Key

## Guide

* Mac Users

1- Install [Xquartz](https://www.xquartz.org/), then reboot your computer.

2- Open your terminal while the Xquartz is running.

3- Type the following command in your terminal (Please use your GWU net id with out the brackets).

```
ssh-keygen -t rsa -f ~/.ssh/gkey -C <Your GW net ID> 
```

4- Hit enter and change your directory.

```
cd ~/.ssh
```

5- Check the list of the files under your directory.

```
ls
```

6- You should be able to see at least 2 files gkey and gkey.pub

7- Enter the following command to see your public key code.

```
cat gkey.pub
```

8- Copy the public code for configuring your GCP dashboard.

9- Now you need to configure the GCP dashboard and the instructions are in the videos that I provided.

10- Finally, in your terminal while you are in the same directory (/.ssh) enter the follwoing command to connect to your VM that you configured.

```
ssh -X -i gkey <Your GWU net ID>@<External IP address from your Dashbaord VMs>
```

* Windows:

1- Install [puttygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

2- Install [Mobaxterm](https://mobaxterm.mobatek.net/download-home-edition.html), the installer version