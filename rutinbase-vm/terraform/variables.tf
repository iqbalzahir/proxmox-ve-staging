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
  description = "Nama nod sasaran di Proxmox VE (contoh: rutinbase)"
  type        = string
  default     = "rutinbase"
}

# ==========================================
# Virtual Machine Configuration
# ==========================================

variable "vm_name" {
  description = "Nama VM yang ingin dicipta"
  type        = string
  default     = "rutinbase-vm-staging"
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

variable "vm_disk_size" {
  description = "Saiz storaj disk (GB) untuk VM"
  type        = number
  default     = 20
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
# Network & Staging Domain Configuration
# ==========================================

variable "vm_bridge" {
  description = "Bridge rangkaian Proxmox (vmbr1 untuk private bridge NAT)"
  type        = string
  default     = "vmbr1"
}

variable "vm_ip" {
  description = "IP address statik VM dalam subnet private (CIDR)"
  type        = string
  default     = "10.10.10.10/24"
}

variable "vm_gateway" {
  description = "Default gateway (IP Proxmox vmbr1)"
  type        = string
  default     = "10.10.10.1"
}

variable "vm_dns" {
  description = "DNS server (IP dnsmasq di Proxmox)"
  type        = string
  default     = "10.10.10.1"
}

variable "vm_domain" {
  description = "Domain tempatan untuk VM (cth: rutinbase.staging)"
  type        = string
  default     = "rutinbase.staging"
}
