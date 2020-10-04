#Keypair 
resource "aws_key_pair" "ec2key" {
  key_name   = var.aws_key_pair_name
  public_key = var.public_key_path
}

# Deploy EC2 Instances
resource "aws_instance" "web" {
  count                       = length(var.instance_count)
  ami                         = var.web_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2key.key_name
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "hello-world-app"
  }
}