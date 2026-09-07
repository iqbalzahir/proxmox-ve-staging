resource "proxmox_virtual_environment_vm" "staging_vm" {
  name      = var.vm_name
  node_name = var.proxmox_node

  clone {
    vm_id = 9000 # Template ubuntu-cloud-template (ID 9000)
  }

  cpu {
    cores   = var.vm_cores
    sockets = var.vm_sockets
  }

  memory {
    dedicated = var.vm_memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = var.vm_disk_size
    discard      = "on"
    ssd          = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.vm_ip
        gateway = var.vm_gateway
      }
    }
    dns {
      servers = [var.vm_dns]
      domain  = "staging"
    }
    user_account {
      username = var.vm_user
      keys     = [trimspace(file(pathexpand(var.ssh_public_key_path)))]
    }
  }

  network_device {
    bridge = var.vm_bridge
  }
}
