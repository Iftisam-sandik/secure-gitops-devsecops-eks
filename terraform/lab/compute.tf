resource "aws_key_pair" "lab" {
  key_name   = "secure-gitops-lab-key"
  public_key = file(pathexpand(var.public_key_path))

  tags = {
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_instance" "lab" {
  #checkov:skip=CKV_AWS_88:Public IPv4 connectivity is intentionally used for this temporary NAT-free GitOps lab.
  #checkov:skip=CKV_AWS_126:Detailed EC2 monitoring is intentionally disabled to minimize temporary lab cost.
  #checkov:skip=CKV_AWS_135:t3.large is EBS-optimized by default, so replacing the existing lab instance only to set this flag is unnecessary.
  #checkov:skip=CKV2_AWS_41:The temporary lab instance does not require AWS API access or an IAM role.

  ami                    = data.aws_ami.ubuntu_2604.id
  instance_type          = "t3.large"
  subnet_id              = aws_subnet.lab_public.id
  vpc_security_group_ids = [aws_security_group.lab.id]
  key_name               = aws_key_pair.lab.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    encrypted             = true
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }

  tags = {
    Name    = "gitops-lab-server"
    Project = "secure-gitops-devsecops-eks"
  }
}
