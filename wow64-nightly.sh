#!/usr/bin/env bash
cd ~
#
apt install sudo -y
sudo apt update
sudo apt install apt-transport-https ca-certificates
#
echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
deb-src http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse' | sudo tee /etc/apt/sources.list > /dev/null
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
sudo apt build-dep wine -y
sudo apt install build-essential flex bison libfreetype6-dev \
libjpeg-dev libpng-dev libtiff-dev libx11-dev libxext-dev \
libxinerama-dev libxrandr-dev libxi-dev libxxf86vm-dev \
libcups2-dev libgphoto2-dev libsqlite3-dev libxml2-dev \
libv4l-dev libasound2-dev libncurses5-dev libudev-dev \
libdbus-1-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
libpcap-dev libsdl1.2-dev libgl1-mesa-dev libosmesa6-dev \
libvulkan-dev libssl-dev -y
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
tar -cjvf wow64-staging.tar.gz wow64-staging
