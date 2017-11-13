#!/bin/bash

# volume setup
vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
	pvcreate ${DEVICE}
	vgcreate data ${DEVICE}
	lvcreate --name volume1 -l 100%FREE data
	mkfs.ext4 /dev/data/volume1
fi
mkdir -p /var/lib/wp
echo '/dev/data/volume1 /var/lib/wp ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/wp

# install wordpress and docker
curl -fsSL https://get.docker.com/ | sh
# enable docker and add perms
usermod -G docker test99
systemctl enable docker
service docker start

mkdir ~/wordpress && cd ~/wordpress
docker run -e MYSQL_ROOT_PASSWORD=<password> -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest


docker pull wordpress
docker run -e WORDPRESS_DB_PASSWORD=<password> --name wordpress --link wordpressdb:mysql -p <server public IP>:80:80 -v "$PWD/html":/var/www/html -d wordpress

# install pip
wget -q https://bootstrap.pypa.io/get-pip.py
python get-pip.py
python3 get-pip.py
rm -f get-pip.py
# install awscli
pip install awscli

# install terraform
cd /usr/local/bin
wget -q https://releases.hashicorp.com/terraform/0.7.7/terraform_0.7.7_linux_amd64.zip
unzip terraform_0.7.7_linux_amd64.zip
# clean up
apt-get clean
rm terraform_0.7.7_linux_amd64.zip
