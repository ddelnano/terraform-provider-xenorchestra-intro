data "xenorchestra_pool" "pool" {
  name_label = "lab-pool-1"
}

data "xenorchestra_template" "vm_template" {
  name_label = "Terraform template VM"
}

data "xenorchestra_sr" "sr" {
  name_label = "ZFS"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "network" {
  name_label = "Pool-wide network associated with eth0"
  pool_id = data.xenorchestra_pool.pool.id
}

resource "xenorchestra_vm" "vm" {
  memory_max = 2147467264
  cpus = 1
  name_label = "XO terraform tutorial"
  template = data.xenorchestra_template.vm_template.id

  network {
    network_id = data.xenorchestra_network.network.id
  }

  network {
    network_id = data.xenorchestra_network.network.id
  }

  disk {
    sr_id = data.xenorchestra_sr.sr.id
    name_label = "VM root volume"
    size = 50214207488
  }
}
