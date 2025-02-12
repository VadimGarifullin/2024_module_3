resource "vkcs_compute_keypair" "key" {
  name       = "existing-key-tf-example"
  public_key = file("${path.module}/ControlVM-public.pem")
}

resource "vkcs_compute_instance" "WEB1" {
  name = "WEB1"
  # AZ and flavor are mandatory
  availability_zone = "MS1"
  flavor_name       = "STD2-1-1"
  # Use block_device to specify instance disk to get full control
  # of it in the future
  block_device {
    source_type      = "image"
    uuid             = "60502e29-e0c8-4c75-afc8-e0b78856626e"
    destination_type = "volume"
    volume_size      = 30
    volume_type      = "ceph-hdd"
    # Must be set to delete volume after instance deletion
    # Otherwise you get "orphaned" volume with terraform
    delete_on_termination = true
  }
  key_pair = vkcs_compute_keypair.key.name
  # Specify at least one network to not depend on project assets
  network {
    port = vkcs_networking_port.WEB1_port.id
  }
  # Specify required security groups if you do not want `default` one
  security_groups = [
      "default",
      vkcs_networking_secgroup.admin.name
  ]
  # If your configuration also defines a network for the instance,
  # ensure it is attached to a router before creating of the instance
  depends_on = [
    vkcs_networking_router_interface.app
  ]
}

resource "vkcs_networking_secgroup" "admin" {
  name        = "icmp"
}

resource "vkcs_networking_secgroup_rule" "etcd_app_clients" {
  security_group_id = vkcs_networking_secgroup.admin.id
  direction         = "ingress"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "vkcs_networking_secgroup_rule" "web80" {
  security_group_id = vkcs_networking_secgroup.admin.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_max    = 80
  port_range_min    = 80
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "vkcs_networking_secgroup_rule" "web443" {
  security_group_id = vkcs_networking_secgroup.admin.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_max    = 443
  port_range_min    = 443
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "vkcs_compute_instance" "WEB2" {
  name = "WEB2"
  # AZ and flavor are mandatory
  availability_zone = "GZ1"
  flavor_name       = "STD2-1-1"
  # Use block_device to specify instance disk to get full control
  # of it in the future
  block_device {
    source_type      = "image"
    uuid             = "60502e29-e0c8-4c75-afc8-e0b78856626e"
    destination_type = "volume"
    volume_size      = 30
    volume_type      = "ceph-hdd"
    # Must be set to delete volume after instance deletion
    # Otherwise you get "orphaned" volume with terraform
    delete_on_termination = true
  }
  # Specify at least one network to not depend on project assets
  network {
    port = vkcs_networking_port.WEB2_port.id
  }
  key_pair = vkcs_compute_keypair.key.name
  # Specify required security groups if you do not want `default` one
  security_groups = [
      "default",
      vkcs_networking_secgroup.admin.name
  ]
  # If your configuration also defines a network for the instance,
  # ensure it is attached to a router before creating of the instance
  depends_on = [
    vkcs_networking_router_interface.app
  ]
}


resource "vkcs_networking_port" "WEB1_port" {
  name       = "WEB1_port"
  network_id = vkcs_networking_network.app.id
  security_group_ids = [vkcs_networking_secgroup.admin.id]
  fixed_ip {
    subnet_id = vkcs_networking_subnet.app.id
  }
}

resource "vkcs_networking_port" "WEB2_port" {
  name       = "WEB2_port"
  network_id = vkcs_networking_network.app.id
  security_group_ids = [vkcs_networking_secgroup.admin.id]
  fixed_ip {
    subnet_id = vkcs_networking_subnet.app.id
  }
}


resource "vkcs_networking_floatingip" "WEB1_associated_fip" {
  pool    = "ext-net"
  port_id = vkcs_networking_port.WEB1_port.id
}


resource "vkcs_networking_floatingip" "WEB2_associated_fip" {
  pool    = "ext-net"
  port_id = vkcs_networking_port.WEB2_port.id
}