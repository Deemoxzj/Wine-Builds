cd ~
sudo sed -i 's/jammy/oracular/g' /etc/apt/sources.list
sudo sed -i 's/jammy/oracular/g' /etc/apt/sources.list.d/ubuntu.sources
sudo sed -i 's/deb/deb [arch=amd64,armhf]/g' /etc/apt/sources.list
sudo sed -i 's/deb/deb [arch=amd64,armhf]/g' /etc/apt/sources.list.d/ubuntu.sources
sudo apt update
sudo apt full-upgrade
sudo apt install git meson -y 
sudo apt build-dep build -y
sudo apt build-dep mesa
sudo apt install meson llvm-dev llvm clang libclang-dev libpolly-19-dev python3-mako python3-yaml
sudo apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf -y
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
