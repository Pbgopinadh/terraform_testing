provider "aws" {}
provider "vault" {
    address = "https://54.160.38.144:8200"  # URL of your Vault server
    token   = var.token
}

data "vault_generic_secret" "example" {
  path = "kv/sshpwd"  # Path to the secret in Vault
}

output "my_secret_value" {
  value = data.vault_generic_secret.example.data["SSH_PWD"]
}

variable "token" {
    default = "hvs.UdS9AFcv7b9XhLvGRVUFcexP"
}

 resource "null_resource" "provisi" {

  connection { # this connection is used to remotly connect using SSH protocal and with user name and password.
    type     = "ssh"
    user     = "ec2-user"
    password = data.vault_generic_secret.example.data["SSH_PWD"]
    host     = aws_instance.instance1.public_ip # we dont need data.resources if its the resources that is going to be created with the current infra code.
  }