# 2024 Module 3

## 🚀 Как запустить

1. Подставить свои данные в `provider.tf`. Должен быть путь `/home/altlinux/`.
2. Создать SSH-ключ и изменить его название в `vm.tf` и `cloudinit.sh`.
3. Включить доступ к API (необходимо активировать **2FA**).

---

## 🛠 Установка Terraform

```sh
curl -O https://hashicorp-releases.mcs.mail.ru/terraform/1.7.1/terraform_1.7.1_linux_amd64.zip

sudo apt-get update
sudo apt-get install unzip -y

unzip terraform*
sudo mv terraform /usr/bin/
```

---

## 🌐 Установка провайдера VKCS

1. Скачайте из **настроек проекта** два файла для Terraform.
2. Файл `vkcs_provider.tf` скопируйте в `/home/altlinux/`.
3. Создайте файл `~/.terraformrc`:

   ```sh
   touch ~/.terraformrc
   ```

4. Инициализируйте Terraform:

   ```sh
   terraform init
   ```

---

## 📦 Установка OpenStack CLI

```sh
sudo apt-get install python3-module-pip
sudo pip3 install python-openstackclient
```

1. Из настроек проекта скачайте **OpenRC-файл**.
2. Впишите свой пароль.
3. Загрузите OpenRC:

   ```sh
   source openrc
   ```

4. Проверьте доступные образы:

   ```sh
   openstack image list --public | grep -i Alt
   ```

---

## 🐳 Установка и настройка Docker

```sh
sudo apt-get install docker-engine
sudo systemctl enable --now docker
```

### 🔧 Решение проблемы нехватки места в `/tmp`

```sh
mount -o remount,size=2G /tmp
```

### 📦 Установка коллекции Ansible для Docker

```sh
ansible-galaxy collection install community.docker
```




