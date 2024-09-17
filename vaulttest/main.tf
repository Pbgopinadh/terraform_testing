provider "aws" {}
provider "vault" {
    address = "https://54.160.38.144:8200"  # URL of your Vault server
    token   = "var.token"
}

data "vault_generic_secret" "example" {
  path = "Secrets/kv/sshpwd"  # Path to the secret in Vault
}

output "my_secret_value" {
  value = data.vault_generic_secret.example.data["SSH_PWD"]
}

variable "token" {}

