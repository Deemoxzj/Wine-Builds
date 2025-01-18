sudo sudo apt install glslang-tools meson -y
cd ~
git clone --depth 1 https://gitlab.com/Ph42oN/dxvk-gplasync.git dxvk-gplasync
git clone --recursive https://github.com/doitsujin/dxvk.git dxvk
cp ~/dxvk-gplasync/patches/dxvk-gplasync-master.patch ~/dxvk
cd dxvk
patch -p 1 -i dxvk-gplasync-master.patch
./package-release.sh master /opt/dxvk-gplasync-master --no-package
cd /opt/
tar -cjvf dxvk-gplasync-master.tar.xz dxvk-gplasync-master
