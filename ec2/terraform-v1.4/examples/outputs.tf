output "instance-ips" {
  description = "IP addresses of created instances"
  value = coalescelist(module.ec2.instance-ips)
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}


output "instance_type" {
  value = module.ec2.instance_type
}

output "instanceName" {
  value = module.ec2.instanceName
}