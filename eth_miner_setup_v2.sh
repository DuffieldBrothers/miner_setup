# miner setup script
# Yu, Steve, and Steven
# Dec 10 2017

# set working dir
cd ~

# download files from cloud
rm -f id_rsa_miner*
rm -f nomachine*
rm -f eth_miner.conf*
rm -f claymore_miner*
wget 45.55.192.222/conf/id_rsa_miner.pub
wget 45.55.192.222/conf/nomachine_6.0.66_2_amd64.deb
wget 45.55.192.222/conf/eth_miner.conf
wget 45.55.192.222/conf/claymore_miner.tar.gz

# set ssh and NX login
mkdir ~/.ssh
cp id_rsa_miner.pub ~/.ssh/authorized_keys
<<<<<<< HEAD
chmod 644 ~/.ssh/authorized_keys
=======
chmod 644 authorized_key
>>>>>>> c14695162e40449ac6522145a84aefda5b0a003d
sudo dpkg -i nomachine_6.0.66_2_amd64.deb
cp id_rsa_miner.pub ~/.nx/config/authorized.crt

# install AMD blockchain driver
wget --referer=http://support.amd.com https://www2.ati.com/drivers/linux/beta/ubuntu/amdgpu-pro-17.40-483984.tar.xz
tar -Jxvf amdgpu-pro-17.40-483984.tar.xz
./amdgpu-pro-17.40-483984/amdgpu-pro-install -y

# setup miner software
tar -xvf claymore_miner.tar.gz

# setup supervisor and start miner
sudo apt-get install supervisor
sudo cp eth_miner.conf /etc/supervisor/conf.d/
sudo chown root:root eth_miner.conf
sudo chmod 644 eth_miner.conf
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start eth_miner
