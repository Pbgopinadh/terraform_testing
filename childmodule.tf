# to create the EC2 instances
resource "aws_instance" "instance1" { 
  ami           = var.ami
  instance_type = var.instance
  vpc_security_group_ids = var.sgs
  tags = {
        name  =  "${var.name}-${var.env}"
  }
 connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip # when a provisioner is included in a instance we can just use self.public_ip to get the public ip of the instances that are going to create.
  }

  provisioner "remote-exec" {
    inline = ["touch provsioner.txt", "echo 'this is sampple' > provsioner.txt" ]
  }
  }

  resource "null_resource" "provisi" {
      depends_on = [aws_instance.instance1]

 triggers = {
    always_run = true
  }

  connection { # this connection is used to remotly connect using SSH protocal and with user name and password.
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.instance1.public_ip # we dont need data.resources if its the resources that is going to be created with the current infra code.
  }

  provisioner "remote-exec" { # remote-exec is say that the below commands should run on the remote host.
    inline = ["touch provsioner1.txt", "echo 'this is sampple1' > provsioner1.txt" ]
  }
    
  }



# to create the DNS records

# resource "aws_route53_record" "appinternal" {
#   zone_id = var.zoneid
#   name    = "${var.name}.app.internal"
#   type    = "A"
#   ttl     = 10
#   records = [aws_instance.instance1.private_ip] # this is how we get the attributes aws_instance(tyep of resource).instance1(resource name).private_ip (attribute)
# }

