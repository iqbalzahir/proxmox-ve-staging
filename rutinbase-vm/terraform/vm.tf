# 1. Hantar skrip Tailscale ke storage snippets Proxmox
resource "proxmox_virtual_environment_file" "tailscale_script" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.proxmox_node

  source_raw {
    data = templatefile("${path.module}/templates/tailscale-init.yaml.tftpl", {
      tailscale_auth_key = var.tailscale_auth_key
      hostname           = var.vm_name
      username           = var.vm_user
      ssh_public_key     = trimspace(file(pathexpand(var.ssh_public_key_path)))
    })
    file_name = "tailscale-init-${var.vm_name}.yaml"
  }
}

# 2. Cipta VM dan sambungkan Tailscale Cloud-Init
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

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_account {
      username = var.vm_user
      keys     = [trimspace(file(pathexpand(var.ssh_public_key_path)))]
    }
    user_data_file_id = proxmox_virtual_environment_file.tailscale_script.id
  }
}
