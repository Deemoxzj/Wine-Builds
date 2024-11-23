cd ~
#
apt update
apt install apt-transport-https ca-certificates
#
sudo rm -rf /etc/apt/sources.list
echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free non-free-firmware
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free non-free-firmware' > /etc/apt/sources.list
sudo apt update
DEBIAN_FRONTEND=noninteractive apt full-upgrade -y --allow-unauthenticated
#
sudo dpkg --add-architecture armhf
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install git meson -y 
sudo DEBIAN_FRONTEND=noninteractive apt build-dep mesa
sudo DEBIAN_FRONTEND=noninteractive apt install meson llvm-19-dev:armhf llvm-19:armhf clang-19:armhf libclang-19-dev:armhf libpolly-19-dev:armhf -y
sudo apt install python3-mako python3-yaml -y
sudo apt install gcc-arm-14-linux-gnueabihf g++-14-arm-linux-gnueabihf -y
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf -y
sudo autoremove -y
#
git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa-sources
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
meson b32 --cross-file=~/cross_armhf.txt --libdir=lib/arm-linux-gnueabihf -Dgallium-drivers=freedreno,zink,virgl,d3d12,softpipe  -Dvulkan-drivers=freedreno -Dgallium-nine=false -Dfreedreno-kmds=kgsl,msm -Dglx=dri -Dxlib-lease=enabled -Dplatforms=x11,wayland -Dvulkan-beta=true -Dvideo-codecs=all -Dglx-direct=true -Dtools=drm-shim,freedreno -Dopengl=true -Dosmesa=true -Dgles1=enabled -Dgles2=enabled -Degl-native-platform=x11 -Degl=enabled -Dpower8=enabled -Dgallium-d3d12-video=enabled -Dgallium-d3d12-graphics=enabled  -Dxmlconfig=enabled -Dgbm=enabled --prefix=~/mesa/
