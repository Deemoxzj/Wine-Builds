cd ~
#
sudo apt update
sudo apt install apt-transport-https ca-certificates
#
#sudo sed -i 's/jammy/oracular/' /etc/apt/sources.list
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade -y
echo 'deb [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ oracular main restricted universe multiverse
deb-src [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ oracular main restricted universe multiverse
deb [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ oracular-updates main restricted universe multiverse
deb-src [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ oracular-updates main restricted universe multiverse
deb [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ oracular-backports main restricted universe multiverse
deb-src [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ oracular-backports main restricted universe multiverse' | sudo tee /etc/apt/sources.list > /dev/null
sudo dpkg --add-architecture armhf
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt --fix-broken install -y
#
sudo DEBIAN_FRONTEND=noninteractive apt install git meson -y 
sudo DEBIAN_FRONTEND=noninteractive apt build-dep mesa
sudo DEBIAN_FRONTEND=noninteractive apt install meson llvm-19-dev:armhf llvm-19:armhf clang:armhf libclang-19-dev:armhf libpolly-19-dev:armhf -y
#sudo DEBIAN_FRONTEND=noninteractive apt install meson llvm-dev:armhf llvm:armhf clang:armhf libclang-dev:armhf libpolly-dev:armhf -y
sudo apt install python3-mako python3-yaml -y
sudo apt install flex 
sudo apt install gcc-arm-14-linux-gnueabihf g++-14-arm-linux-gnueabihf -y
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf -y
sudo autoremove -y
sudo apt-get install pkg-config:armhf
sudo apt install cmake git wget g++-arm-linux-gnueabihf zlib1g-dev:armhf libexpat1-dev:armhf libdrm-dev:armhf libx11-dev:armhf libxext-dev:armhf libxdamage-dev:armhf libxcb-glx0-dev:armhf libx11-xcb-dev:armhf libxcb-dri2-0-dev:armhf libxcb-dri3-dev:armhf libxcb-present-dev:armhf libxshmfence-dev:armhf libxxf86vm-dev:armhf libxrandr-dev:armhf libwayland-dev:armhf wayland-protocols:armhf libwayland-egl-backend-dev:armhf libxcb-shm0-dev:armhf pkg-config:armhf -y
#
git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa-sources
git clone https://github.com/MastaG/mesa-turnip-ppa.git
cp mesa-turnip-pp/turnip-patches/* mesa-sources/
#
echo '[binaries]
c = 'arm-linux-gnueabihf-gcc'
cpp = 'arm-linux-gnueabihf-g++'
ar = 'arm-linux-gnueabihf-ar'
strip = 'arm-linux-gnueabihf-strip'
pkgconfig = 'arm-linux-gnueabihf-pkg-config'
[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'arm'
endian = 'little'' > ~/cross_armhf.txt
#
cd mesa-sources
patch -p1 < *.patch
#
meson b32 --cross-file=~/cross_armhf.txt --libdir=lib/arm-linux-gnueabihf -Dgallium-drivers=freedreno,zink,virgl,d3d12,softpipe  -Dvulkan-drivers=freedreno -Dgallium-nine=false -Dfreedreno-kmds=kgsl,msm -Dglx=dri -Dxlib-lease=enabled -Dplatforms=x11,wayland -Dvulkan-beta=true -Dvideo-codecs=all -Dglx-direct=true -Dtools=drm-shim,freedreno -Dopengl=true -Dosmesa=true -Dgles1=enabled -Dgles2=enabled -Degl-native-platform=x11 -Degl=enabled -Dpower8=enabled -Dgallium-d3d12-video=enabled -Dgallium-d3d12-graphics=enabled  -Dxmlconfig=enabled -Dgbm=enabled --prefix=~/mesa/
cd b32
ninja install -j$(nproc)
tar -xvf mesa-armhf-devel.tar.gz ~/mesa/
