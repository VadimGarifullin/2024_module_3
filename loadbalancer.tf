resource "vkcs_lb_loadbalancer" "app" {
  name          = "app-tf"
  description   = "Loadbalancer for resources/datasources testing"
  vip_subnet_id = vkcs_networking_subnet.app.id
}
resource "vkcs_lb_pool" "http" {
  name        = "http-tf"
  description = "Pool for http member/members testing"
  listener_id = vkcs_lb_listener.app_http.id
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
}

resource "vkcs_lb_listener" "app_http" {
  name            = "app-http-tf-example"
  description     = "Listener for resources/datasources testing"
  loadbalancer_id = vkcs_lb_loadbalancer.app.id
  protocol        = "HTTP"
  protocol_port   = 80
}

resource "vkcs_lb_member" "front_http1" {
  pool_id       = vkcs_lb_pool.http.id
  address       = vkcs_compute_instance.WEB1.access_ip_v4
  protocol_port = 80
}

resource "vkcs_lb_member" "front_http2" {
  pool_id       = vkcs_lb_pool.http.id
  address       = vkcs_compute_instance.WEB2.access_ip_v4
  protocol_port = 80
}


resource "vkcs_lb_pool" "https" {
  name        = "http-tf"
  description = "Pool for http member/members testing"
  listener_id = vkcs_lb_listener.app_https.id
  protocol    = "HTTPS"
  lb_method   = "ROUND_ROBIN"
}

resource "vkcs_lb_listener" "app_https" {
  name            = "app-http-tf-example"
  description     = "Listener for resources/datasources testing"
  loadbalancer_id = vkcs_lb_loadbalancer.app.id
  protocol        = "HTTPS"
  protocol_port   = 443
}

resource "vkcs_lb_member" "front_https1" {
  pool_id       = vkcs_lb_pool.https.id
  address       = vkcs_compute_instance.WEB1.access_ip_v4
  protocol_port = 443
}

resource "vkcs_lb_member" "front_https2" {
  pool_id       = vkcs_lb_pool.https.id
  address       = vkcs_compute_instance.WEB2.access_ip_v4
  protocol_port = 443
}





resource "vkcs_networking_floatingip" "base_fip" {
  pool        = "ext-net"
  description = "floating ip in external net tf example"
}


resource "vkcs_networking_floatingip" "associated_fip" {
  pool    = "ext-net"
  port_id = vkcs_lb_loadbalancer.app.vip_port_id
}

