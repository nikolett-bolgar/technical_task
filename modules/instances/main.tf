#Keypair 
resource "aws_key_pair" "ec2key" {
  key_name   = var.aws_key_pair_name
  public_key = var.public_key_path
}

# Deploy EC2 Instances
resource "aws_instance" "web" {
  ami                         = var.web_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2key.key_name
  tags = {
    Name = "hello-world-app"
  }
}