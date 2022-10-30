#create a ec2 instance with existing vpc subnet
resource "aws_instance" "dev-instance" {
  ami                    = var.inst_ami
  instance_type          = var.inst_type
  count                  = 1
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.lb.id]
  key_name               = "wadson"
  tags = {
    Name = "dev-ec2-server"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./wadson.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum install -y nginx",
      "sudo service nginx restart",
      "sudo systemctl enable nginx.service",
      "sudo service nginx status",
    ]
  }
}