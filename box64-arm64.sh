sudo apt update
sudo apt upgrade
sudo apt install checkinstall -y
cd /opt/
rm -rf box64 -y
git clone https://github.com/ptitSeb/box64
cd box64
mkdir build
cd build
cmake .. -DARM64=ON -DBAD_SIGNAL=ON -DBOX32=ON -DBOX32_BINFMT=ON -DSD8G2=ON -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo --install-prefix=/usr/
sudo checkinstall make install
