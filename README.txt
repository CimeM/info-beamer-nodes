
# Instalation

Download the info-beamer tool to you Raspberry:
Jessie: `wget https://info-beamer.com/jump/download/player/info-beamer-pi-0.9.4-beta.ce8d97-jessie.tar.gz`
Wheezy: `wget https://info-beamer.com/jump/download/player/info-beamer-pi-0.9.4-beta.ce8d97-wheezy.tar.gz`

More info about the lib: https://info-beamer.com/download/player

Update your Raspberry and install required packages
`apt-get update`
`apt-get install libevent-2.0-5 libavformat56 libpng12-0 libfreetype6 libavresample2`


Unpack all the downloaded package, install and test
`tar xf info-beamer-pi.tar.gz`
cd info-beamer-pi`
./info-beamer samples/shader`


Download the nodes and test the functionality
`git clone https://github.com/CimeM/info-beamer-nodes.git`
`./info-beamer info-beamer-nodes/samples/photos`

Configure the I2C communication
`sudo apt-get install python-smbus i2c-tools`

configure I2C support for the ARM core and linux kernel
`sudo raspi-config`
select `8 Access options`
select `A7 I2C`
confirm by confirming "yes"
save and reboot

Manual kernel support instalation
open file 
`sudo nano /etc/modules`

add to the end of the file
`i2c-bcm2708 `
`i2c-dev`
save with Control-X Y <return>


open file and comment entries with hash (#) 
`sudo nano /etc/modprobe.d/raspi-blacklist.conf`

file should end up with this entries
`#blacklist spi-bcm2708`
`#blacklist i2c-bcm2708`

edit the file
`sudo nano /boot/config.txt`
find and configure next entries:

`dtparam=i2c1=on`
`dtparam=i2c_arm=on`

reboot your device

`sudo reboot`



test the tool: 
RPI version 1
`sudo i2cdetect -y 0`

RPI version 2
`sudo i2cdetect -y 1`
This will return the addresses of connected I2C devices


Example repository for code runnable using info-beamer (https://info-beamer.com/).
More example code can be found in the info-beamer github repositories: https://github.com/info-beamer

Feel free to fork and contribute.
