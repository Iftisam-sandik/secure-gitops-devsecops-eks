output "lab_instance_id" {
  description = "GitOps lab EC2 instance ID"
  value       = aws_instance.lab.id
}

output "lab_public_ip" {
  description = "Current public IPv4 address of the GitOps lab instance"
  value       = aws_instance.lab.public_ip
}

output "ubuntu_ami_id" {
  description = "AMI currently used by the GitOps lab instance"
  value       = aws_instance.lab.ami
}
