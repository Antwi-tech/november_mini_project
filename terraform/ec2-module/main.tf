
resource "aws_security_group" "aws-sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Django App"
    from_port   = 8087
    to_port     = 8087
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # or restrict to your IP
  }
}

resource "aws_instance" "app-isntance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.aws-sg.id]

  tags = {
    Name = "modular-ec2"
  }
}
