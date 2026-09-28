resource "aws_security_group" "lab" {
  name        = "gitops-lab-sg"
  description = "Security group for the temporary GitOps lab server"
  vpc_id      = aws_vpc.lab.id

  ingress {
    description = "SSH from admin IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "gitops-lab-sg"
    Project = "secure-gitops-devsecops-eks"
  }
}
