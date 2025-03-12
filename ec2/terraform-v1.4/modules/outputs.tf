output "instance-ips" {
  description = "IP addresses of created instances"
  value = coalescelist(
    aws_instance.ec2-instance[*].private_ip,
    [""]
  )
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2-instance[0].id
}


output "instance_type" {
  value = aws_instance.ec2-instance[0].instance_type
}

output "instanceName" {
  value = aws_instance.ec2-instance[0].tags["Name"]
}
