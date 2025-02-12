#!/bin/bash

echo "Hello i'm script"

source cloud.conf
echo $TF_VAR_project_id
echo $TF_VAR_username
echo $TF_VAR_password
export TF_VAR_project_id=$TF_VAR_project_id
export TF_VAR_username=$TF_VAR_username
export TF_VAR_password=$TF_VAR_password
cd /home/altlinux/  && terraform apply --auto-approve

terraform output -raw lb_public_ip > /home/altlinux/lb.ip

terraform output -raw WEB1_public_ip > /home/altlinux/WEB1.ip
terraform output -raw WEB2_public_ip > /home/altlinux/WEB2.ip