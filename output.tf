output "lb_public_ip" {
  value       = vkcs_networking_floatingip.base_fip.address
}

output "WEB1_public_ip" {
  value       = vkcs_networking_floatingip.WEB1_associated_fip.address
}

output "WEB2_public_ip" {
  value       = vkcs_networking_floatingip.WEB2_associated_fip.address
}

output "test" {
  value       = vkcs_compute_instance.WEB1.network[0]
}
#terraform output -raw lb_public_ip > /home/altlinux/lb.ip
#sudo ln -s /home/altlinux/cloudinit.sh /usr/bin/cloudinit.sh