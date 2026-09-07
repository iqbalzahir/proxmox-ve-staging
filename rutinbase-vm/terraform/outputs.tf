output "vm_name" {
  description = "Nama VM yang dicipta"
  value       = proxmox_virtual_environment_vm.staging_vm.name
}

output "vm_target_node" {
  description = "Proxmox node tempat VM di-host"
  value       = proxmox_virtual_environment_vm.staging_vm.node_name
}

output "vm_id" {
  description = "ID VM di Proxmox"
  value       = proxmox_virtual_environment_vm.staging_vm.id
}

output "vm_ip" {
  description = "IP Address VM dalam Private Subnet"
  value       = var.vm_ip
}

output "vm_domain" {
  description = "Domain tempatan VM"
  value       = var.vm_domain
}

output "ssh_command" {
  description = "Arahan SSH menggunakan domain .staging"
  value       = "ssh ${var.vm_user}@${var.vm_domain}"
}

output "ssh_command_ip" {
  description = "Arahan SSH menggunakan IP terus melalui Tailscale Subnet Router"
  value       = "ssh ${var.vm_user}@${split("/", var.vm_ip)[0]}"
}
