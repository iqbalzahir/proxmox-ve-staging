output "vm_name" {
  description = "Nama VM yang dicipta"
  value       = proxmox_vm_qemu.staging_vm.name
}

output "vm_target_node" {
  description = "Proxmox node tempat VM di-host"
  value       = proxmox_vm_qemu.staging_vm.target_node
}

output "vm_id" {
  description = "ID VM di Proxmox"
  value       = proxmox_vm_qemu.staging_vm.id
}

output "tailscale_hostname" {
  description = "Hostname VM dalam Tailnet Tailscale"
  value       = var.vm_name
}

output "ssh_command" {
  description = "Arahan SSH untuk menyambung ke VM melalui Tailscale"
  value       = "ssh ${var.vm_user}@${var.vm_name}"
}
