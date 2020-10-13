## Raspberry Pi Production Setup

In this post, I outline steps I use to setup a Raspberry Pi system to act as an embedded controller. Here is the hardware that I have used:
 
* Raspberry Pi 4 - Model B
(4GB RAM)
* 32GB Samsung microSDHC UHS-I Card
* Macbook Pro - Running macOS Sierra


## SD Card Setup

The first step is to put the Raspberry Pi OS onto the SD Card. First, download a the zip file of the Raspberry Pi OS with Desktop from [here](https://www.raspberrypi.org/downloads/raspberry-pi-os/). At the time of writing, I am using the 2020-08-20 release.  

Once downloaded, unzip the file. To get the image onto the SD card, follow [these instructions](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md). I found that the troubleshooting instructions in the article are not clearly labeled so, and may be mistaken as mandatory. The final two commands you will execute (assuming things go smoothly) are:

```
sudo dd bs=1m if=path_of_your_image.img of=/dev/rdiskN; sync  

sudo diskutil eject /dev/rdiskN
```


## Install Software

* [rpi-clone](https://github.com/billw2/rpi-clone) - Software for making clones of your SD card. I am using [this commit](https://github.com/billw2/rpi-clone/commit/07f536e9d93cb5b50635415ee0fa46f498614ee4) at the moment.
