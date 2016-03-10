
## Instalation

Download the info-beamer tool to you Raspberry:
Jessie: wget https://info-beamer.com/jump/download/player/info-beamer-pi-0.9.4-beta.ce8d97-jessie.tar.gz
Wheezy: wget https://info-beamer.com/jump/download/player/info-beamer-pi-0.9.4-beta.ce8d97-wheezy.tar.gz

More info about the lib: https://info-beamer.com/download/player

Update your Raspberry and install required packages
apt-get update
apt-get install libevent-2.0-5 libavformat56 libpng12-0 libfreetype6 libavresample2


Unpack all the downloaded package, install and test
tar xf info-beamer-pi.tar.gz
cd info-beamer-pi
./info-beamer samples/shader


Download the nodes and test the functionality
git clone https://github.com/CimeM/info-beamer-nodes.git


Example repository for code runnable using info-beamer (https://info-beamer.com/).
More example code can be found in the info-beamer github repositories: https://github.com/info-beamer

Feel free to fork and contribute.
