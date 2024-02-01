# 2024_module_3
как запустить:
подставить свои данные в provider.tf, должен быть /home/altlinux/, создать ssh ключ и изменить его названия в vm.tf и cloudinit.sh
включить доступ к api, нужно включить 2fa

#Установка terraform

curl -O https://hashicorp-releases.mcs.mail.ru/terraform/1.7.1/terraform_1.7.1_linux_amd64.zip

sudo apt-get update

sudo apt-get install unzip -y

unzip terraform*

sudo mv terraform /usr/bin/


2. Установка провайдера VKCS

скачиваем из настройки проекта два файла для terraform

vkcs_provider.tf копируем в корень /home/altlinux/

terraform.rc:

touch ~/.terraformrc


terraform init


установка openstack cli
sudo apt-get install python3-module-pip
sudo pip3 install python-openstackclient

из настроек проекта скачать openrc, вписать свой пароль

source openrc

openstack image list --public | grep -i Alt





####Docker Control
sudo apt-get install docker-engine
sudo systemctl enable --now docker

#решение проблемы не хватки места в tmpfs
mount -o remount,size=2G /tmp

ansible-galaxy collection install community.docker




