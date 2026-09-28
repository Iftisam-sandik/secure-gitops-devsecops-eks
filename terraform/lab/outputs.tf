output "lab_instance_id" {
  description = "EC2 instance ID of the GitOps lab server"
  value       = aws_instance.lab.id
}

output "lab_public_ip" {
  description = "Public IPv4 address of the GitOps lab server"
  value       = aws_instance.lab.public_ip
}

output "ubuntu_ami_id" {
  description = "Ubuntu 26.04 AMI selected for the lab server"
  value       = data.aws_ami.ubuntu_2604.id
}
