resource "aws_key_pair" "lab" {
  key_name   = "secure-gitops-lab-key"
  public_key = file(pathexpand(var.public_key_path))

  tags = {
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_instance" "lab" {
  ami                    = data.aws_ami.ubuntu_2604.id
  instance_type          = "t3.large"
  subnet_id              = aws_subnet.lab_public.id
  vpc_security_group_ids = [aws_security_group.lab.id]
  key_name               = aws_key_pair.lab.key_name

  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name    = "gitops-lab-server"
    Project = "secure-gitops-devsecops-eks"
  }
}
