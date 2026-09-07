# 1. Hantar skrip Tailscale / Cloud-Init ke storage snippets Proxmox
resource "proxmox_virtual_environment_file" "tailscale_script" {
  provider     = proxmoxve
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.proxmox_node

  source_raw {
    data = templatefile("${path.module}/templates/tailscale-init.yaml.tftpl", {
      tailscale_auth_key = var.tailscale_auth_key
      hostname           = var.vm_name
    })
    file_name = "tailscale-init-${var.vm_name}.yaml"
  }
}

# 2. Cipta VM dan jalankan skrip tadi masa boot
resource "proxmox_vm_qemu" "staging_vm" {
  name        = var.vm_name
  target_node = var.proxmox_node
  clone       = var.vm_template

  cores   = var.vm_cores
  sockets = var.vm_sockets
  memory  = var.vm_memory

  scsihw = "virtio-scsi-pci"
  boot   = "order=scsi0"

  # Setting Cloud-Init asas
  os_type   = "cloud-init"
  ipconfig0 = "ip=dhcp"
  ciuser    = var.vm_user
  sshkeys   = file(pathexpand(var.ssh_public_key_path))

  # Sambungkan skrip Tailscale yang di-upload tadi
  cicustom = "user=local:snippets/${proxmox_virtual_environment_file.tailscale_script.file_name}"

  depends_on = [proxmox_virtual_environment_file.tailscale_script]
}
