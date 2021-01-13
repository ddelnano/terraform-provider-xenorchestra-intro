data "xenorchestra_pool" "pool" {
  name_label = "lab-pool-1"
}

data "xenorchestra_sr" "sr" {
  name_label = "ZFS"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "net" {
  name_label = "Lab Network (VLAN 10)"
  pool_id = data.xenorchestra_pool.pool.id
}

resource "xenorchestra_vm" "imported" {
    auto_poweron     = false
    cpus             = 2
    memory_max       = 2147483648
    name_description = "Debian 10 Cloudinit ready template from XO Hub"
    name_label       = "Debian 10 Cloudinit self-service"
    template = "template"

    disk {
        attached   = true
        name_label = "debian root"
        size       = 4294967296
        # Refactor to use data sources rather than IDs
        sr_id      = data.xenorchestra_sr.sr.id
        # sr_id      = "86a9757d-9c05-9fe0-e79a-8243cb1f37f3"
    }

    network {
        attached    = true
        mac_address = "c2:03:35:47:79:8f"
        # Refactor to use data sources rather than IDs
        network_id  = data.xenorchestra_network.net.id
        # network_id  = "6c4e1cdc-9fe0-0603-e53d-4790d1fce8dd"
    }

    lifecycle {
      ignore_changes = [
        template,
      ]
    }
}

