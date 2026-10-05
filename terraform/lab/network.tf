resource "aws_vpc" "lab" {
  #checkov:skip=CKV2_AWS_11:VPC Flow Logs are omitted for this temporary cost-sensitive lab.

  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "gitops-lab-vpc"
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_default_security_group" "lab" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name    = "gitops-lab-default-sg"
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_subnet" "lab_public" {
  #checkov:skip=CKV_AWS_130:Automatic public IPv4 assignment is intentional for the temporary NAT-free public lab subnet.

  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.50.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name    = "gitops-lab-public-subnet"
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_internet_gateway" "lab" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name    = "gitops-lab-igw"
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_route_table" "lab_public" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab.id
  }

  tags = {
    Name    = "gitops-lab-public-rt"
    Project = "secure-gitops-devsecops-eks"
  }
}

resource "aws_route_table_association" "lab_public" {
  subnet_id      = aws_subnet.lab_public.id
  route_table_id = aws_route_table.lab_public.id
}
