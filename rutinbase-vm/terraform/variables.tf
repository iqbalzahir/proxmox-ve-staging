# ==========================================
# Proxmox VE Connection Variables
# ==========================================

variable "proxmox_api_url" {
  description = "URL API Proxmox VE (contoh: https://100.107.199.57:8006/api2/json)"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "Token ID API Proxmox VE (contoh: root@pam!terraform-token)"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "Token Secret API Proxmox VE"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Benarkan self-signed certificate SSL"
  type        = bool
  default     = true
}

variable "proxmox_node" {
  description = "Nama nod sasaran di Proxmox VE (contoh: pve)"
  type        = string
  default     = "pve"
}

# ==========================================
# Virtual Machine Configuration
# ==========================================

variable "vm_name" {
  description = "Nama VM yang ingin dicipta"
  type        = string
  default     = "staging-vm-1"
}

variable "vm_template" {
  description = "Nama template Proxmox yang digunakan untuk clone"
  type        = string
  default     = "ubuntu-cloud-template"
}

variable "vm_cores" {
  description = "Bilangan CPU cores untuk VM"
  type        = number
  default     = 2
}

variable "vm_sockets" {
  description = "Bilangan CPU sockets untuk VM"
  type        = number
  default     = 1
}

variable "vm_memory" {
  description = "Kapasiti memori (RAM) dalam MB"
  type        = number
  default     = 4096
}

variable "vm_user" {
  description = "Nama default user untuk Cloud-Init"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path ke SSH Public Key untuk dimasukkan ke VM"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

# ==========================================
# Tailscale Configuration
# ==========================================

variable "tailscale_auth_key" {
  description = "Tailscale Auth Key untuk pendaftaran automatik VM ke tailnet"
  type        = string
  sensitive   = true
}
