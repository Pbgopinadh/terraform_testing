provider "aws" {}
provider "vault" {
    address = "https://54.160.38.144:8200"  # URL of your Vault server
    token   = var.token
}

data "vault_generic_secret" "example" {
  path = "/v1/kv/data/sshpwd"  # Path to the secret in Vault
}

output "my_secret_value" {
  value = data.vault_generic_secret.example.data["SSH_PWD"]
}

variable "token" {
    default = "hvs.UdS9AFcv7b9XhLvGRVUFcexP"
}

