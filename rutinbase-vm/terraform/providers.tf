terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.70.0"
    }
  }
}

provider "proxmox" {
  endpoint  = replace(var.proxmox_api_url, "/api2/json", "/")
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  insecure  = var.proxmox_tls_insecure

  ssh {
    username    = "root"
    private_key = file(pathexpand("~/.ssh/id_ed25519"))
    node {
      name    = var.proxmox_node
      address = "100.107.199.57"
    }
  }
}
