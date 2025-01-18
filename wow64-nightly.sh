#!/usr/bin/env bash
cd ~
#
apt install sudo -y
sudo apt update
sudo apt install apt-transport-https ca-certificates
#
echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular-updates main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular-backports main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ oracular-security main restricted universe multiverse
deb-src http://security.ubuntu.com/ubuntu/ oracular-security main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular-proposed main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ oracular-proposed main restricted universe multiverse' | sudo tee /etc/apt/sources.list > /dev/null
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
sudo apt build-dep wine -y
sudo apt install build-essential flex bison libfreetype6-dev \
libjpeg-dev libpng-dev libtiff-dev libx11-dev libxext-dev \
libxinerama-dev libxrandr-dev libxi-dev libxxf86vm-dev \
libcups2-dev libgphoto2-dev libsqlite3-dev libxml2-dev \
libv4l-dev libasound2-dev libncurses5-dev libudev-dev \
libdbus-1-dev  \
libpcap-dev libsdl1.2-dev libgl1-mesa-dev libosmesa6-dev \
libvulkan-dev libssl-dev -y
#sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
#sudo apt install mingw-w64 -y
sudo apt install libsane-dev -y
sudo apt install libavcodec-dev libavformat-dev libavutil-dev -y
sudo apt install oss4-base oss4-dev -y
sudo apt install libsmbclient-dev -y
sudo apt install samba samba-common samba-dev -y

#
git clone https://gitlab.winehq.org/wine/wine.git wine-source
git clone https://gitlab.winehq.org/wine/wine-staging.git
cd wine-source
../wine-staging/staging/patchinstall.py --all
mkdir build
cd build
../configure --enable-archs=i386,x86_64 --prefix=/opt/wow64-staging/
make -j$(nproc)
make install
#
cd /opt/
tar -cjvf wow64-staging.tar.xz /opt/wow64-staging
