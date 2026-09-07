terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
    proxmoxve = {
      source  = "bpg/proxmox"
      version = ">= 0.70.0"
    }
  }
}

# Provider untuk pengurusan VM Proxmox (telmate)
provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = var.proxmox_tls_insecure
}

# Provider untuk pengurusan fail Cloud-Init / Snippets (bpg)
provider "proxmoxve" {
  endpoint  = replace(var.proxmox_api_url, "/api2/json", "/")
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  insecure  = var.proxmox_tls_insecure
}
