# 1. Cipta VM di Proxmox VE
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

# 2. Automasi Pendaftaran & Pembersihan Rekod DNS di Proxmox dnsmasq
resource "null_resource" "auto_dnsmasq" {
  triggers = {
    vm_name      = var.vm_name
    vm_domain    = var.vm_domain
    vm_ip        = split("/", var.vm_ip)[0]
    proxmox_host = regex("https?://([^/:]+)", var.proxmox_api_url)[0]
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(pathexpand("~/.ssh/id_ed25519"))
    host        = self.triggers.proxmox_host
  }

  # Cipta rekod DNS bila apply
  provisioner "remote-exec" {
    inline = [
      "echo 'address=/${self.triggers.vm_domain}/${self.triggers.vm_ip}' > /etc/dnsmasq.d/${self.triggers.vm_name}.conf",
      "systemctl restart dnsmasq"
    ]
  }

  # Padam rekod DNS bila destroy
  provisioner "remote-exec" {
    when = destroy
    inline = [
      "rm -f /etc/dnsmasq.d/${self.triggers.vm_name}.conf",
      "systemctl restart dnsmasq"
    ]
  }

  depends_on = [proxmox_virtual_environment_vm.staging_vm]
}
